#!/bin/sh
set -e

usage() {
  cat <<'EOF'
Usage: install-deps.sh

Environment variables:
  DRY_RUN=1           Print install commands without executing them
EOF
}

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  usage
  exit 0
fi

if [ "$(uname -s)" != "Darwin" ]; then
  echo "ERROR: This installer currently supports macOS only." >&2
  exit 1
fi

run() {
  if [ -n "${DRY_RUN:-}" ]; then
    printf 'DRY_RUN:'
    for arg in "$@"; do
      printf ' %s' "$arg"
    done
    printf '\n'
    return 0
  fi
  "$@"
}

ensure_brew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "ERROR: Homebrew not found. Install it first." >&2
    exit 1
  fi
}

brew_install() {
  pkg="$1"
  if brew list --formula "$pkg" >/dev/null 2>&1; then
    echo "OK: $pkg already installed"
    return 0
  fi
  run brew install "$pkg"
}

brew_install_cask() {
  pkg="$1"
  if brew list --cask "$pkg" >/dev/null 2>&1; then
    echo "OK: $pkg already installed (cask)"
    return 0
  fi
  run brew install --cask "$pkg"
}

ensure_cmd() {
  cmd="$1"
  pkg="$2"
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "OK: $cmd already available"
    return 0
  fi
  brew_install "$pkg"
}

ensure_cmds() {
  for entry in "$@"; do
    cmd=${entry%%:*}
    pkg=${entry#*:}
    ensure_cmd "$cmd" "$pkg"
  done
}

has_rgb_tmux_terminfo() {
  infocmp -x tmux-256color 2>/dev/null | grep -Eq 'RGB|Tc|setrgbf=|setrgbb='
}

ensure_brew

ensure_cmds \
  "git:git" \
  "nvim:neovim" \
  "node:node" \
  "rg:ripgrep" \
  "tmux:tmux" \
  "delta:git-delta"

brew_install_cask ghostty
brew_install_cask font-meslo-lg-nerd-font

ensure_tmux_terminfo() {
  if has_rgb_tmux_terminfo; then
    echo "OK: RGB-capable terminfo tmux-256color available"
    return 0
  fi

  echo "INFO: installing tmux-256color terminfo (ncurses + tic)"
  brew_install ncurses
  ncurses_prefix="$(brew --prefix ncurses)"
  terminfo_src="$(find "${ncurses_prefix}/share/terminfo" -name tmux-256color -print -quit)"
  if [ -z "$terminfo_src" ]; then
    echo "ERROR: tmux-256color terminfo not found under ${ncurses_prefix}/share/terminfo" >&2
    exit 1
  fi
  run mkdir -p "${HOME}/.terminfo"
  run tic -x -o "${HOME}/.terminfo" "$terminfo_src"
}

ensure_tmux_terminfo

TPM_ROOT="${HOME}/.tmux/plugins"
TPM_DIR="${TPM_ROOT}/tpm"

if [ ! -d "$TPM_DIR" ]; then
  if ! command -v git >/dev/null 2>&1; then
    echo "ERROR: git is required to install tmux TPM." >&2
    exit 1
  fi
  run mkdir -p "$TPM_ROOT"
  run git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo "OK: tmux TPM already installed"
fi
