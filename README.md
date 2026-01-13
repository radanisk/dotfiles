# Dotfiles

Personal configuration for Neovim, Git, and tmux.

## Prerequisites

* macOS
* Homebrew
* Git
* make

## Setup

1. Clone the repository: `git clone git@github.com:radanisk/dotfiles.git`
2. Navigate to the repository: `cd dotfiles`
3. Install dependencies: `make deps-install`
4. Install Neovim config: `make nvim-install`
5. Install Git/tmux configs: `make dotfiles-install`

## Local Git config

This repo keeps personal Git identity out of the shared `gitconfig`. Create a local override at `~/.gitconfig.local` with your name and email.

```
cp files/gitconfig.local.example ~/.gitconfig.local
```

`make dotfiles-install` will create `~/.gitconfig.local` from the template if it does not exist.
