# Dotfiles

Personal configuration for Neovim, Git, and tmux.

## Requirements

Required:
* Linux or macOS
* Neovim (latest stable recommended)
* make
* Git
* Node.js (for some Neovim plugins)
* tmux
* ripgrep (`rg`)
* git-delta (`delta`)

Optional:
* git-lfs (for LFS-enabled repos)
* tmux TPM (`~/.tmux/plugins/tpm/tpm`)

## Setup

1. Clone the repository: `git clone git@github.com:radanisk/dotfiles.git`
2. Navigate to the repository: `cd dotfiles`
3. (Optional) Check dependencies: `make doctor`
4. Install Neovim config: `make nvim-install`
5. Install Git/tmux configs: `make dotfiles-install`

## Neovim layout

* `files/init.lua` loads core config
* `files/lua/config/` contains options, keymaps, and lazy.nvim bootstrap
* `files/lua/plugins/` holds plugin specs grouped by domain (ui, lsp, git, editing, tools, languages, markdown)

## Local Git config

This repo keeps personal Git identity out of the shared `gitconfig`. Create a local override at `~/.gitconfig.local` with your name and email.

```
cp files/gitconfig.local.example ~/.gitconfig.local
```

`make dotfiles-install` will create `~/.gitconfig.local` from the template if it does not exist.

## Install behavior

Symlinks are created via `scripts/link.sh`, which is idempotent and makes a timestamped backup if a target already exists. Preview changes with `DRY_RUN=1 make dotfiles-install`.
