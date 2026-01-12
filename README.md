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
* tmux TPM (`~/.tmux/plugins/tpm/tpm`)
* Nerd Font with Powerline symbols (for UI icons in Neovim and tmux statusline)
* ripgrep (`rg`)
* git-delta (`delta`)
* Ghostty (optional; only if you use the terminal config)

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
