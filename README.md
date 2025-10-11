# Aleksandr B. Ivanov's dotfiles

This repository contains configuration files (dotfiles) to set up a development environment the way I like it. It primarily focuses on configuring Neovim, Git, and tmux.

## Requirements

* Linux or macOS
* Neovim (latest stable recommended)
* make
* Git
* Node.js (for some Neovim plugins)
* tmux

## Setup

1. Clone the repository: `git clone git@github.com:radanisk/dotfiles.git`
2. Navigate to the repository: `cd dotfiles`
3. Install Neovim plugins and configurations: `make nvim-install`
4. Install other dotfiles (gitconfig, tmux.conf, etc.): `make dotfiles-install`

## Overview

This repository contains configurations for:

* **Neovim**: A highly customized Neovim setup with a plugin manager (`lazy.nvim`), LSP support, treesitter, and various plugins for enhanced development experience.
* **Git**: Git configuration settings for user identity, core settings, merge tools, and LFS.
* **Tmux**: Tmux configuration for improved terminal workflow with vim-like key bindings and plugins.

The installation uses a Makefile to symlink the configuration files to their appropriate locations in the home directory.
