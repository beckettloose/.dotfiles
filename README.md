# beckettloose/.dotfiles

## Introduction

This repository contains most of my configuration files for Linux and Mac OS utility programs (primarily command line software like Zsh, Tmux, and Neovim). It is not by itself a generic system for deploying your dotfiles, however you are more than welcome to use it as an example to build your own dotfiles repository.

## Goals

- Provide a consistent experience across a variety of platforms and architectures
    - Rely on widely supported programs for core functionality (e.g. Zsh, GNU Stow, Tmux, Neovim)
    - Use Tmux for windows and sessions rather than the terminal emulator itself. This allows for the use of any terminal emulator, or even working over ssh without changing the user experience and workflow.
- Prioritize simplicity of user experience without restricting capabilities
    - Don't clutter up the prompt line with unimportant information or fancy themes
    - Add functionality without forcing complex workflows
    - Create more efficient keybinds that are faithful to the defaults
- Optimize performance and reduce waiting times
    - Use Powerlevel10k with instant prompt mode to keep new shell startup time under 500ms and prompt return time around 100ms
    - Use snacks.nvim quickfile and bigfile to optimize loading times, especially for big files (2GiB test file opens in ~10sec, which is pretty good for Neovim)

## Inspiration

- The stow system in this repository is based on [ThePrimeagen/.dotfiles](https://github.com/ThePrimeagen/.dotfiles)
- My Neovim configuration was adapted from [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) but split into multiple files like ThePrimeagen's.
- The tmux-sessionizer and tmux-cht.sh scripts are stolen from ThePrimeagen (but modified significantly)
- A bunch of utility scripts from [Evan Hahn](https://evanhahn.com/scripts-i-wrote-that-i-use-all-the-time/)

## Cool Features

- Uses GNU Stow to automatically deploy config files to your home directory using symlinks. This means most changes made in the repo will apply automatically without re-running the install script (except for adding/removing files and modules).
- Zsh + OhMyZsh + Powerlevel10k: a powerful and extensible environment that is simple and performant when configured appropriately.
- Custom Zsh Line Editor (zle) widgets allow for deep integration of shell utilities
- Simple Tmux config with revised keybinds prioritizing speed
- Powerful Neovim configuration with lots of useful macros and plugins

## Requirements

1. Zsh (to use OhMyZsh and many of my custom scripts)
2. git (to clone this repo)
3. GNU Stow (`>= 2.4.0` for the `--dotfiles` argument)

### Bonus utilities that I usually install

- tmux (multiple terminals in one)
- neovim (my preferred text editor)
- fzf ("fuzzy finder" for efficiently searching large lists, used in a few of my scripts and in Neovim)
- ripgrep (recursively search a directory for lines matching a pattern)
- fd-find (better alternative to `find`)
- ncal (print a calendar to the command line)
- lazygit (powerful tui for git)

## How This Repository Works

This repository uses GNU Stow along with a few custom shell scripts to automatically manage local configuration files (dotfiles) across various unix-like systems. Files are 'installed' to the proper location using symbolic links so that you can track changes to all of the files easily in a single git repository.

Each directory in the root of this repository is considered a 'module' in Stow terminology. A module is the most granular unit of control when deciding which files are included on a given system. When a module is stowed, the full directory tree inside the module is symlinked to the user's home folder. Files in different modules may have conflicting names, as long as both modules are never stowed simultaneously (some systems may use a different set of modules)

To stow the appropriate files for your system, set the environment variable `DOTFILES_STOW_FOLDERS` to a comma-separated list of the modules you wish to install. Then, run the `install` script. If stow finds that any of the files already exist (e.g. your old zsh configuration), it will not overwrite them with the files from the repo. In this case, you should move the conflicting file elsewhere (e.g. `mv .zshrc .zshrc.bak`) and run the shell script again.

If you clone this repo to any location other than `~/.dotfiles`, you will need to set the `DOTFILES` environment variable so that the shell scripts know how to find your modules.

## Usage

This is a basic overview of how to use the dotfiles repo. For a complete guide on system setup and configuration, see [SETUP.md](SETUP.md)

1. Install any prerequisites (git, zsh, fzf, ripgrep, etc.)
2. Create any top level config directories like `~/.local/` and `~/.config/` manually to prevent stow from attempting to symlink the entire thing.
3. Clone this repo to `~/.dotfiles`
4. Create and source the `~/.zsh_system` file that sets up your environment variables (including `DOTFILES_STOW_FOLDERS` and `DOTFILES` if required)
5. Run the `./install` script to stow all of the selected modules. If any errors occur, correct them and run the script again.

## Important Files and Directories

### Modules

Below is a high-level overview of each module in this repository.

- `aerospace`: Configuration for the Aerospace Tiling Window Manager (Mac OS)
- `alacritty`: Configuration for the Alacritty terminal emulator
- `bin`: Useful scripts and associated data
- `git`: My gitconfig
- `lazygit`: Configuration for LazyGit
- `nvim`: My Neovim configuration
- `p10k`: Custom powerlevel10k configuration
- `pulseaudio`: (deprecated) Custom pulseaudio config for my Behringer XR18 for systems running PulseAudio
- `tmux`: My tmux configuration (as a submodule)
- `wezterm`: My basic wezterm configuration
- `xr18`: Custom pipewire and wireplumber configuration for my Behringer XR18
- `zsh`: My base zsh configuration
- `zsh_macos`: Zsh config for mac OS
- `zsh_mint`: Zsh config for Linux Mint

### Files

- README.md: this file
- SETUP.md: Detailed instructions on system configuration
- clean-env: unstow all modules.
- install: stow all modules in the DOTFILES_STOW_FOLDERS env var.

## Module Design and Features

### Aerospace

The `aerospace` module contains the configuration file for the Aerospace tiling window manager for MacOS.

I'm not personally a huge fan of tiling window managers, but Apple's spaces implementation slows down my workflow significantly with agonizingly long animations, confusing behavior, and awful keybinds that other programs override. It infuriated me so much that a custom WM was the best solution. This module will probably be deprecated and removed once I get my Framework 13 Pro (on which I plan to install Fedora KDE).

I don't really remember what I changed in this config other than switching the base prefix from Cmd to Cmd+Alt.

### Alacritty

The `alacritty` module contains the configuration file for the Alacritty terminal emulator, along with a Tokyo Night color scheme.

I think I had a weird crashing issue with Wezterm related to Nvidia drivers or Wayland so I have been using Alacritty in the meantime until that is patched (which it might be already). The very basic configuration sets the following options:

- Tokyo Night color scheme
- 110x28 default window size
- Font JetBrainsMono Nerd Font, 13.5pt

### Bin

The `bin` module contains useful shell scripts and their associated data. The `dot-local/scripts/bin/` directory which is for user-executable programs and `dot-local/scripts/resources/` directory for non-user executable programs or resource files (zle widget setup scripts, sound effects, etc.).

Scripts of note:
- `tmux-sessionizer`: quickly create and attach to tmux sessions named after project directories
- `copy` and `pasta`: platform agnostic wrappers for pbcopy/pbpaste and xclip that work on Mac and Linux
- `prettypath`: prints each path in `$PATH` on a separate line
- `fzf-ssh-setup`: quickly search ssh hosts using fzf
- `fzf-git-switch-setup`: quickly switch git branches (local or remote) using fzf
- `fzf-git-checkout-tag-setup`: quickly checkout a git tag using fzf
- `tmux-sessionizer-setup`: use `tmux-sessionizer` from a zle widget

### Git

The `git` module contains my global git configuration and ignore file. This contains some basic settings like my git name and email, along with some minor adjustments I've made to help improve performance and usability. I put these files in `~/.config/git/` to avoid cluttering up my home directory.

The global gitignore system uses the `core.excludesfile` option to point at `~/.config/git/ignore`. I currently use this feature to globally ignore all `.DS_Store` files.

I have also chosen to disable some of the advice options as they clutter up the terminal.

Additionally, there are aliases for `git log` which print a prettified commit graph at 3 different verbosity levels. I still use this often even though I have lazygit, because it shows the entire history for all branches, tags, and stashes, not just the checked-out commit.

The `[includeIf "gitdir:~/work/"]` section activates a secondary `.gitconfig` when the repository is inside of `~/work/`, and overrides `user.email`.

### LazyGit

The `lazygit` module simply contains the `~/.config/lazygit/config.yml` file. This configures the following parameters:

- Quit if not in a repository
- Disable mouse mode
- Use 24h timestamps
- Nerd font enabled
- Fuzzy filtering
- Auto wrap commit message body at 72 chars
- Custom Commands
    - Push to specific remote
    - Pull from specific remote
    - Push selected commit
    - Add empty commit
    - Conventional commit wizard

### Nvim

The `nvim` module contains my Neovim configuration files, symlinked to `~/.config/nvim`. Complete details can be found [here](https://github.com/beckettloose/.nvim).

### P10k

The `p10k` module contains the `~/.p10k.zsh` file used to configure [powerlevel10k](https://github.com/romkatv/powerlevel10k). The file header includes the options used to generate this file, however I have made the following changes afterwords:

- Replace the regular prompt icon and VCS branch icon with nerd font symbols
- Replace the Vi mode prompt characters to N, V, and R to match editor mode
- Change the VCS untracked symbol from `?` to `U`

### PulseAudio

The `pulseaudio` module contains a special configuration for PulseAudio specific to my Linux desktop PC, and is intended to interface with my Behringer XR18 mixer. The mixer presents itself as a single ~18 channel bidirectional device, so this handles the creation of virtual sinks and sources that map to mono channels or stereo pairs on the main device. I can then use `pavucontrol` to route individual apps to different mixer channels. Note that this module is deprecated as I have switched to Fedora KDE which uses PipeWire and Wireplumber for audio.

### Tmux

The `tmux` module contains my tmux configuration file. This used to be a much more complicated system forked from [gpakosz/.tmux](https://github.com/gpakosz/.tmux), but I found that it really wasn't worth the complexity, and a config that was closer to default would be a better choice in the long run. The main features of this config are listed below:

- Change prefix to `C-a` to allow nested `screen` sessions
- Add shortcut for reloading config file
- Shortcuts for `tmux-sessionizer` and `tmux-cht.sh` scripts
- Start numbering windows and panes at 1
- Disable automatic window renaming
- Rename current window with `M-,`
- Automatically renumber windows
- Use vim-style `hjkl` keys to navigate and manipulate panes and windows
- Select windows by number with `M-1` through `M-0`
- Create new window with `M-c`
- Vim-style shortcuts for copy mode, with system clipboard support
- Custom color scheme (based on Tokyo Night)

### Wezterm

The `wezterm` module contains my Wezterm configuration file. My wezterm configuration is relatively simple and has the following parameters:

- `80x20` initial window size
- Default font size of 14
- Tokyo Night color scheme
- No window padding
- Fixed window size increments
- Disable tab bar
- Disable all default key bindings
- Re-enable basic keybinds
    - Copy/paste
    - Debug overlay
    - Command palette

### XR18

The `xr18` module contains the configuration files required to support the use of my Behringer XR18 mixer as a multi-channel audio interface. While Linux ships with the necessary drivers to use the XR18, it exposes it as single 18-in/18-out audio interface which is not optimal for my use case.

These files configure Pipewire to spin up a series of virtual loopback nodes that remap individual channels (or stereo pairs) from the XR18 into separate mono and stereo devices. This allows me to route the audio from different applications to separate mixer channels and then mix them together on the XR18 itself. I also return the output of some mix buses so that they can be used as a source for chat and streaming applications. The exact setup is described below:

- Output Sinks (PC to XR18)
    - Main Audio Output (Stereo, maps to XR18 inputs 1/2)
    - Chat Audio Output (Mono, maps to XR18 input 6)
    - Media Audio Output (Stereo, maps to XR18 inputs 7/8)
- Input Sources (XR18 to PC)
    - Stream Audio Input (Stereo, maps to XR18 outputs 3/4)
    - Microphone Audio Input (Mono, maps to XR18 output 6)

There is also a simple wireplumber config that sets the default source and sink to the appropriate loopback interfaces.

This module is one of the rare "success cases" for Linux audio. While many people seem to struggle with intermittent or hard to diagnose problems, this setup has worked brilliantly for me. Additionally, it is done without any paid software, unlike the Windows version of this setup (which used VB Audio's VoiceMeeter Potato, a very high quality but paid piece of software)

### Zsh

The `zsh` module contains my base zsh configuration applicable to all systems. The initial entry point is the `~/.zshrc` file, which performs the following actions.

1. Attempt to show the powerlevel10k instant prompt if available
2. Configure and enable oh-my-zsh
3. Configure `$PATH` deduplication
4. Source `~/.zsh_system`
5. Source `~/.zsh_dist` (if it exists)
6. Source `~/.zsh_profile`
7. Source `~/.p10k.zsh` (if it exists)

The `zsh_system` file is unique to each machine, and must be created manually by the user. It should start off by setting the `DOTFILES` and `DOTFILES_STOW_FOLDERS` environment variables. After that, any additional statements can be added to configure other environment variables like `PATH`, or define functions used only on this specific computer. Think of this file as your new `zshrc`.

The `zsh_dist` file is unique to the operating system type (macOS, Linux Mint, etc.). This is described further in the sections below. The file is only loaded if it exists, as not all systems will have it.

The `zsh_profile` file contains user specific configuration items that aren't part of the init process. In my case, this includes things like:

- Set environment variables (like `EDITOR`)
- Create aliases for `nvim`, `lazygit`, zsh reloading, and `tmux` commands
- Special functions that rely on shell context like the working directory or last exit code
- Command to quickly profile the shell startup time
- zsh keybind and zle widget setup blocks
- Alias to grep existing aliases

The `p10k.zsh` file contains configuration parameters for powerlevel10k. Like `zsh_dist`, it is only loaded if it exists.

### Zsh MacOS

The `zsh_macos` module contains zsh initialization specific to macOS. In my case, this consists of adding the homebrew completions directory to `$FPATH` and running `compinit`.

### Zsh Mint

The `zsh_mint` module contains zsh initialization specific to Linux Mint. In my case, this is just a alias to flush the DNS cache.
