# .dotfiles

THIS IS NOT A GENERIC SOFTWARE TOOL THAT YOU CAN USE AS-IS. IT IS SPECIFIC TO MY COMPUTER AND WORKFLOW, AND WILL PROBABLY BREAK YOUR SYSTEM.
You are, however, more than welcome to use this repo for inspiration when building your own dotfiles repo (which I highly recommend doing.)

This repository contains all of my config files for *nix (mostly GNU/Linux and macOS) operating systems and associated utilities.

## Inspiration
- The stow system in this repository is based on ThePrimeagen/.dotfiles.
- The custom tmux configuration is forked from OhMyTmux.
- The neovim config is based on theprimagen's nvim config and kickstart.nvim.
- The cht.sh and tmux-sessionizer scripts are adapted from ThePrimeagen.

## How this repo works
This repository uses a combination of GNU Stow and a few custom shell scripts to automatically manage configuration files across multiple *nix systems of various types. Files are 'installed' to the proper location using symlinks so that only one copy of the files exists on a system at a given time. Therefore, if a user modifies an installed file, those changes always exist in the repository (excluding creating/deleting files).

Directories in the root of this repository are known as 'modules'. A module is the most granular unit of control when choosing which files are stowed on a given system. All files and directories inside a module are symlinked to the current user's home folder. Files may have conflicting names, as long as they are in different modules that are never stowed simultaneously (see my zsh_(os)_only implementation).

To stow the appropriate files for your system, run the corresponding shell script. If stow finds that any of the files already exist (e.g. your old zsh configuration), it will not overwrite them with the files from the repo. In this case, you should move the conflicting file elsewhere and run the shell script again.

If you use any of the scripts, you may need to modify the dotfiles directory so that the scripts know where your modules are stored. By default it is `~/.dotfiles`, but this may differ depending on where you choose to clone the repo.

## Important Items

### Directories
Directories not listed below will contain configuration files for the program or system it is named after.

- bin: contains useful scripts and associated data.
- zsh_mac_only: zsh config specifically for mac OS.
- zsh_debian_only: zsh config specifically for Debian.
- zsh_mint_only: zsh config specifically for Linux Mint.
- zsh_wsl_only: zsh config specifically for WSL.

### Files
- clean-env: unstow all modules.
- install: stow all modules in the STOW_FOLDERS env var.
- debian: stow folders required on debian.
- macos: stow folders required on mac OS.
- mint: stow folders required for Linux Mint.
- wsl: stow folders required for WSL.
