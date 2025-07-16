# .dotfiles

## Introduction

This repository contains all of my config files for *nix (mostly GNU/Linux and macOS) operating systems and associated utilities.

WARNING: THIS REPOSITORY IS HIGHLY CUSTOMIZED FOR MY SYSTEM AND WILL NOT WORK OUT OF THE BOX ON YOURS.

You are more than welcome to re-use this code and repo structure for managing your own dotfiles, but you will need to change most of the content.

## Inspiration

- The stow system in this repository is based on [ThePrimeagen/.dotfiles](https://github.com/ThePrimeagen/.dotfiles)
- The custom tmux configuration is forked from [gpakosz/.tmux](https://github.com/gpakosz/.tmux)
- The Neovim config is based on ThePrimeagen's nvim config and [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- The cht.sh and tmux-sessionizer scripts are adapted from ThePrimeagen

## Requirements

1. zsh (to use oh-my-zsh and my custom scripts without modification)
2. git
3. GNU Stow

### Bonus utilities that I usually install

- tmux (Multiple terminals in one window)
- neovim (Good text editor)
- fzf ("Fuzzy finder" for efficiently searching large lists)
- ripgrep (Recursively search for text in a file tree)
- [omz-git-branch](https://github.com/cpwillis/omz-git-branch) (To truncate long branch names in prompt)

## How this repo works

This repository uses a combination of GNU Stow and a few custom shell scripts to automatically manage configuration files (dotfiles) across multiple *nix systems of various types. Files are 'installed' to the proper location using symlinks so that only one copy of the files exists on a system at a given time. Therefore, if a user modifies an installed file, those changes always exist in the repository (excluding creating/deleting files).

Directories in the root of this repository are known as 'modules'. A module is the most granular unit of control when choosing which files are stowed on a given system. All files and directories inside a module are symlinked to the current user's home folder. Files may have conflicting names, as long as they are in different modules that are never stowed simultaneously (see my `.zsh_platform` implementation).

To stow the appropriate files for your system, set the environment variable `DOTFILES_STOW_FOLDERS` to a comma-separated list of the modules you wish to install. Then, run the `install` script. If stow finds that any of the files already exist (e.g. your old zsh configuration), it will not overwrite them with the files from the repo. In this case, you should move the conflicting file elsewhere (`.zshrc -> .zshrc.bak`) and run the shell script again.

If you use any of the scripts, you may need to modify the dotfiles directory so that the scripts know where your modules are stored. By default it is `~/.dotfiles`, but this may differ depending on where you choose to clone the repo.

## Important Items

### Modules

- bin: Useful scripts and associated data
- git: My gitconfig
- nvim: My Neovim configuration
- pulseaudio: Custom pulseaudio config for my Behringer XR-18
- tmux: My tmux configuration (as a submodule)
- tpm_fido: TPM-FIDO systemd user unit
- zsh: My base zsh configuration
- zsh_dist_debian: Zsh config for Debian
- zsh_dist_macos: Zsh config for mac OS
- zsh_dist_mint: Zsh config for Linux Mint
- zsh_dist_ubuntu_server: Zsh config for Ubuntu Server
- zsh_dist_wsl: Zsh config for WSL

### Files

- clean-env: unstow all modules.
- install: stow all modules in the DOTFILES_STOW_FOLDERS env var.
- fresh-install: set up a fresh installation and select the module list

## Usage (To Be Updated...)

1. Install the requirements (and any bonus utilities)
2. Make sure the files you wish to stow do not already exist (and if they do exist, rename them before continuing)
2. Clone this repo to ~/.dotfiles
3. Run the correct script for your system.
4. Set up any utilities or environment variables that are unique to your system in the `~/.zsh_system` file.
