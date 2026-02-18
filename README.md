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
    - Add functionality without forcing complex workflows
    - Create more efficient keybinds without overriding defaults
- Optimize performance and reduce waiting times
    - Use powerlevel10k to keep new shell startup time under 500ms and prompt return time around 100ms
    - Use snacks.nvim quickfile and bigfile to optimize loading times, especially for big files (2GiB test file opens in ~10sec)

## Inspiration

- The stow system in this repository is very similar to [ThePrimeagen/.dotfiles](https://github.com/ThePrimeagen/.dotfiles)
- My neovim configuration was adapted from [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) but split into multiple files like ThePrimeagen's.
- The tmux-sessionizer and tmux-cht.sh scripts are adapted from ThePrimeagen
- A bunch of utility scripts from [Evan Hahn](https://evanhahn.com/scripts-i-wrote-that-i-use-all-the-time/)

## Cool Features

- GNU stow for automatically deploying config files
- zsh + oh-my-zsh + powerlevel10k: lightning fast and simple, yet extremely powerful combination (when configured correctly)
- Simple tmux config with revised keybinds prioritizing speed
- Powerful neovim configuration with lots of useful macros and plugins

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

## Important Files and Directories

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

## Module Design and Features

### bin

The `bin` module contains useful shell scripts and their associated data. Data is located in `~/.config/`, and the scripts themselves are located in `~/.local/scripts/`. This contains the `bin/` directory which is for user-executable programs and the `resources/` directory for non-user executable programs (zle widget setup scripts, etc.).

Scripts of Note:
- `tmux-sessionizer`: quickly create and attach to tmux sessions named after project directories
- `copy` and `pasta`: platform agnostic wrappers for pbcopy and xclip that work on Mac and Linux
- `prettypath`: prints each path in `$PATH` on a separate line
- `fzf-ssh-setup`: quickly search ssh hosts using fzf
- `fzf-git-switch-setup`: quickly switch git branches (local or remote) using fzf
- `fzf-git-checkout-tag-setup`: quickly checkout a git tag using fzf
- `tmux-sessionizer-setup`: use `tmux-sessionizer` from a zle widget

### git

The `git` module contains my `.gitconfig` file. The `[includeIf "gitdir:~/work/"]` section activates a secondary `.gitconfig` when working inside of the `~/work/` directory, overriding the `user.email` value. This file is not committed to the repository for security purposes. Additionally, there are the `git lg` aliases which print a prettified commit graph in 3 different verbosity levels.

### lazygit

The lazygit module simply contains the `~/.config/lazygit/config.yml` file. Nothing special in here other than some personal preferences.

### nvim

The `nvim` module contains my Neovim configuration files, symlinked to `~/.config/nvim`. Complete details can be found [here](https://github.com/beckettloose/.nvim).

### p10k

The `p10k` module contains the `~/.p10k.zsh` file used to configure [powerlevel10k](https://github.com/romkatv/powerlevel10k). The file header includes the options used to generate this file, however I have made the following changes afterwords:

- Replace the regular prompt icon and VCS branch icon with nerd font symbols
- Replace the Vi mode prompt characters to N, V, and R to match editor mode
- Change the VCS untracked symbol from `?` to `U`

### pulseaudio

The `pulseaudio` module contains a special configuration for PulseAudio specific to my Linux desktop PC, and is intended to interface with my Behringer XR-18 mixer. The mixer presents itself as a single ~18 channel bidirectional device, so this handles the creation of virtual sinks and sources that map to mono channels or stereo pairs on the main device. I can then use `pavucontrol` to route individual apps to different mixer channels.

### tmux

The `tmux` module contains my tmux configuration file. This used to be a much more complicated system forked from [gpakosz/.tmux](https://github.com/gpakosz/.tmux), but I wanted something more simple and easy to modify. Features of note are listed below:

- Change prefix to `C-a` to allow nested `screen` sessions
- Add shortcut for reloading config file
- Shortcuts for `tmux-sessionizer` and `tmux-cht.sh` scripts
- Start numbering windows and panes at 1
- Disable automatic window renaming
- Add non-prefixed shortcut for renaming current window
- Automatically renumber windows when one is closed
- Use hjkl keys to navigate and manipulate panes and windows
- Select windows by number with `M-1` through `M-0`
- Create new window with `M-c`
- Vim-style shortcuts for copy mode, with system clipboard support
- Custom color scheme

### tpm_fido (deprecated)

I made this to test tpm-fido on my desktop Linux PC but no longer need it. This will be removed in the future.

### wezterm

The `wezterm` module contains my Wezterm configuration file. My wezterm configuration is relatively simple and has the following parameters:

- `80x20` initial window size
- Default font size of 14
- Tokyo Night color scheme
- No window padding
- Fixed window size increments
- Disable tab bar
- Disable all default key bindings

### zsh

The `zsh` module contains my base zsh configuration applicable to all systems. The initial entrypoint is the `~/.zshrc` file, which performs the following actions.

1. Attempt to show the powerlevel10k instant prompt if available
2. Configure and enable oh-my-zsh
3. Configure `$PATH` deduplication
4. Source `~/.zsh_system`
5. Source `~/.zsh_dist` if it exists
6. Source `~/.zsh_profile`
7. Source `~/.p10k.zsh` (powerlevel10k config file)

The `zsh_system` file is unique to each machine, and must be created manually by the user. It should start off by setting the `DOTFILES` and `DOTFILES_STOW_FOLDERS` environment variables. After that, any additional statements can be added to configure other environment variables like `PATH`, or defince functions used only on this specific computer. Think of this file as your new `zshrc`.

The `zsh_dist` file is unique to the operating system type (macOS, Ubuntu, Linux Mint, etc.). This is described further in the sections below.

The `zsh_profile` file contains user specifc configuration items that aren't part of the init process. In my case, this includes things like:

- Setting `EDITOR` environment variables
- Aliases for `nvim`, `lazygit`, zsh reloading, and `tmux` commands
- Special functions that change the current directory of the shell
- Command to quickly profile the shell startup time
- zsh keybind and zle widget setup blocks
- Alias to grep existing aliases

### zsh_macos

The `zsh_macos` module contains zsh initialization specific to macOS. In my case, this consists of adding the homebrew completions directory to `$FPATH` and running `compinit`.

### zsh_mint

The `zsh_mint` module contains zsh initialization specific to Linux Mint. In my case, this is just a alias to flush the DNS cache.
