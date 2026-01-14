# Dotfiles

Personal configuration for Neovim, Git, tmux, and Ghostty.

## Prerequisites

* macOS (deps installer is macOS-only)
* Homebrew
* Git
* make

`make deps-install` installs the remaining dependencies via Homebrew (including a Nerd Font for tmux glyphs). See `scripts/install-deps.sh` for the full list.

## Setup

1. Clone the repository: `git clone git@github.com:radanisk/dotfiles.git`
2. Navigate to the repository: `cd dotfiles`
3. Install dependencies: `make deps-install`
4. Install Neovim config: `make nvim-install`
5. Install Git/tmux/Ghostty configs: `make dotfiles-install`

## Update

Run `make update` to update Homebrew packages/casks, tmux plugins (TPM),
and Neovim plugins (Lazy).

## Local Git config

This repo keeps personal Git identity out of the shared `gitconfig`. Create a local override at `~/.gitconfig.local` with your name and email.

```
cp files/gitconfig.local.example ~/.gitconfig.local
```

`make dotfiles-install` will create `~/.gitconfig.local` from the template if it does not exist.
