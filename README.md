# Dotfiles

Personal configuration for Neovim, Git, and tmux.

## Requirements

Required:
* macOS
* Neovim (latest stable recommended)
* mise
* make
* Git
* Node.js (for some Neovim plugins)
* tmux
* ripgrep (`rg`)
* git-delta (`delta`)

Optional:
* tmux TPM (`~/.tmux/plugins/tpm/tpm`)

## Setup

1. Clone the repository: `git clone git@github.com:radanisk/dotfiles.git`
2. Navigate to the repository: `cd dotfiles`
3. Install Neovim config: `make nvim-install`
4. Install Git/tmux configs: `make dotfiles-install`

## Local Git config

This repo keeps personal Git identity out of the shared `gitconfig`. Create a local override at `~/.gitconfig.local` with your name and email.

```
cp files/gitconfig.local.example ~/.gitconfig.local
```

`make dotfiles-install` will create `~/.gitconfig.local` from the template if it does not exist.

## Preferences

This repo favors keeping configuration as consistent as possible across machines. Local overrides are used only to keep personal identity out of the repo; otherwise they are avoided to keep behavior uniform.
Deployment automation is intentionally minimal; the primary focus is improving the actual application configurations to support UX/DX and a stable daily workflow for a single user.

## Install behavior

Symlinks are created via `scripts/link.sh`, which is idempotent and makes a timestamped backup if a target already exists. Preview changes with `DRY_RUN=1 make dotfiles-install`.
