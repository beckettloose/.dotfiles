# .dotfiles

## Introduction

This repository contains most of my configuration files for *nix operating systems (primarily Linux and macOS) along with their associated utility programs.

You are more than welcome to use this repo as a template, but you will likely want to change most of the content to work how you want.

## Goals

- Provide a consistent experience across a variety of platforms and architectures
    - Rely on widely supported programs for core functionality (e.g. zsh, stow, tmux, neovim)
    - Use tmux for windows and sessions rather than the terminal emulator itself (allows the use of any terminal emulator, or even working over ssh)
- Prioritize simplicity of user experience
    - Don't clutter up the prompt line with unimportant information or fancy themes
    - Add functionality without forcing complex features or workflows
    - Create more efficient keybinds without overriding defaults
- Optimize performance and reduce waiting times
    - Use powerlevel10k to keep shell loading time under 500ms and prompt return time around 100ms
    - Use snacks.nvim quickfile and bigfile to optimize loading times, especially for big files (2GiB test file opens in ~10sec)

## Inspiration

- The stow system in this repository is very similar to [ThePrimeagen/.dotfiles](https://github.com/ThePrimeagen/.dotfiles)
- My neovim configuration was adapted from [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) but split into multiple files like ThePrimeagen's.
- The tmux-sessionizer and tmux-cht.sh scripts are adapted from ThePrimeagen
- A bunch of utility scripts from [Evan Hahn](https://evanhahn.com/scripts-i-wrote-that-i-use-all-the-time/)

## Requirements

1. zsh (to use oh-my-zsh and my custom scripts without modification)
2. git (to clone this repo)
3. GNU Stow (`>= 2.4.0` for the `--dotfiles` argument)

### Bonus utilities that I usually install

- tmux (multiple terminals in one)
- neovim (my preferred text editor)
- fzf ("fuzzy finder" for efficiently searching large lists, used in a few of my scripts)
- ripgrep (recursively search a directory for lines matching a pattern)
- fd-find (better alternative to `find`)
- ncal (print a calendar to the command line)
- lazygit (powerful tui for git)

## How This Repository Works

This repository uses GNU Stow along with a few custom shell scripts to automatically manage local configuration files (dotfiles) across various unix-like systems. Files are 'installed' to the proper location using symlinks so that you can track changes to all of the files easily in a single git repository.

Directories in the root of this repository are considered 'modules' in stow terminology. A module is the most granular unit of control when choosing which files are stowed on a given system. When a module is stowed, all files and directories inside it are symlinked to the current user's home folder. Files in different modules may have conflicting names, as long as they are never stowed simultaneously (see my `.zsh_dist` implementation).

To stow the appropriate files for your system, set the environment variable `DOTFILES_STOW_FOLDERS` to a comma-separated list of the modules you wish to install. Then, run the `install` script. If stow finds that any of the files already exist (e.g. your old zsh configuration), it will not overwrite them with the files from the repo. In this case, you should move the conflicting file elsewhere (`.zshrc -> .zshrc.bak`) and run the shell script again.

If you clone this repo to any location other than `~/.dotfiles`, you will need to set the `DOTFILES` environment variable so that the shell scripts know how to find your modules.

## Usage

This is a basic overview of how to use the dotfiles repo. For a complete guide on system setup and configuration, see [SETUP.md](SETUP.md)

1. Install any prerequisites (git, zsh, fzf, ripgrep, etc.)
2. Create any top level config directories like `~/.local/` and `~/.config/` manually to prevent stow from adopting them directly.
3. Clone this repo to `~/.dotfiles`
4. Create and source the `~/.zsh_system` file that sets up your environment variables (including `DOTFILES_STOW_FOLDERS` and `DOTFILES` if required)
5. Run the `./install` script to stow all of the selected modules. If any errors occur, correct them and run the script again.

## Important Items

### Modules

- bin: Useful scripts and associated data
- git: My gitconfig
- nvim: My Neovim configuration
- p10k: Custom powerlevel10k configuration
- pulseaudio: Custom pulseaudio config for my Behringer XR-18
- tmux: My tmux configuration (as a submodule)
- tpm_fido: TPM-FIDO systemd user unit
- wezterm: My basic wezterm configuration
- zsh: My base zsh configuration
- zsh_macos: Zsh config for mac OS
- zsh_mint: Zsh config for Linux Mint

### Files

- README.md: this file
- SETUP.md: Detailed instructions on system configuration
- clean-env: unstow all modules.
- install: stow all modules in the DOTFILES_STOW_FOLDERS env var.
