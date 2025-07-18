# .dotfiles

## Introduction

This repository contains ~all~ most of my config files for unix-like operating systems (mostly Linux and macOS) along with their associated utilities.

You are more than welcome (even encouraged) to use this code and repo structure as a template for managing your own dotfiles, but you will need to change much of the content to be compatible with your system and software.

## Inspiration

- The stow system in this repository is heavily based on [ThePrimeagen/.dotfiles](https://github.com/ThePrimeagen/.dotfiles)
- The custom tmux configuration is forked from [gpakosz/.tmux](https://github.com/gpakosz/.tmux)
- The Neovim config is based on ThePrimeagen's nvim config and [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- The cht.sh and tmux-sessionizer scripts are adapted from ThePrimeagen

## Requirements

1. zsh (to use oh-my-zsh and my custom scripts without modification)
2. git
3. GNU Stow (`>= 2.4.0` for the `--dotfiles` argument)

### Bonus utilities that I usually install

- tmux (Multiple terminals in one window)
- neovim (Good text editor)
- fzf ("Fuzzy finder" for efficiently searching large lists, used in a few of my scripts)
- ripgrep (Recursively search for text in a file tree)
- [omz-git-branch](https://github.com/cpwillis/omz-git-branch) (To truncate long branch names in omz prompt)

## How this repo works

This repository uses GNU Stow along with a few custom shell scripts to automatically manage local configuration files (dotfiles) across various unix-like systems. Files are 'installed' to the proper location using symlinks so that you can track all of the files easily in a single git repository.

Directories in the root of this repository are considered 'modules' in stow terminology. A module is the most granular unit of control when choosing which files are stowed on a given system. All files and directories inside a module are symlinked to the current user's home folder. Files in different modules may have conflicting names, as long as they are never stowed simultaneously (see my `.zsh_dist` implementation).

To stow the appropriate files for your system, set the environment variable `DOTFILES_STOW_FOLDERS` to a comma-separated list of the modules you wish to install. Then, run the `install` script. If stow finds that any of the files already exist (e.g. your old zsh configuration), it will not overwrite them with the files from the repo. In this case, you should move the conflicting file elsewhere (`.zshrc -> .zshrc.bak`) and run the shell script again.

If you clone this repo to any location other than `~/.dotfiles`, you will need to set the `DOTFILES` environment variable so that the shell scripts know where your modules are stored.

## Usage

1. Install any prerequisites (git, zsh, fzf, ripgrep, etc.)
2. Clone this repo to `~/.dotfiles`. You may choose a different location but additional configuration is required.
3. Create any system directory trees manually to prevent stow from adopting the highest level dir (usually `.local` or similar)
4. Create and source the `~/.zsh_system` file that sets up your environment variables (including `DOTFILES_STOW_FOLDERS`)
5. Run the `./install` script to stow all of the selected modules. If any errors occur, correct them and run the script again.

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
- zsh_dist_wsl: Zsh config for Ubuntu on WSL

### Files

- clean-env: unstow all modules.
- install: stow all modules in the DOTFILES_STOW_FOLDERS env var.

