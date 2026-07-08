# beckettloose/.dotfiles Setup

This document provides basic instructions for setting up a Linux or macOS user account to my preferred specifications. Directory structure, utility programs, and dotfiles setup will be covered.

## Creating the Home Directory Structure

Upon logging into the system for the first time, the following directories should be created:

- `external`: Cloned repositories or source code for projects that you aren't actively developing. (neovim, asdf-vm, etc.)
- `personal`: Personal projects that are in active development, but not intended for other users (may not even be made public)
- `scratch`: A temporary place to store and work with files.
- `work`: Work projects. This is not required on personal machines.

These directories are used to categorize projects such that they can be easily filtered when using the tmux-sessionizer script. The script will search `~/`, `~/external/`, `~/personal/`, and `~/work/` at a depth of 1 level, adding each directory it finds to the list of potential Tmux sessions.

## Installing utility packages

### System Packages for Debian-based Systems

Run the following commands in the terminal to install common tools

```sh
sudo apt update
sudo apt install zsh wget git stow tmux fzf ripgrep fd-find ncal
```

### System Packages for MacOS Based Systems

Run the command below to install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Run the following commands in the terminal to install common tools

```sh
brew update
brew install wget git stow tmux fzf ripgrep fd lazygit
```

### System Packages for Fedora-based systems (with `dnf`)

```sh
sudo dnf install git stow tmux fzf ripgrep fd-find
```

## Terminal Environment Setup

### Switching to Zsh

To switch the shell to Zsh, run the following command. (Note: this should not be required on Mac OS because Zsh is already the default)

```sh
chsh -s /bin/zsh $USER
```

Close and reopen the terminal (or relog on console only machines) to start Zsh. If prompted, choose to not create a configuration file yet. The dotfiles repo will override it anyways.

### Installing OhMyZsh

Run the following command to install OhMyZsh (must be run in a Zsh session)

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Installing Dotfiles

Run the following command to ensure these top level directories exist. If you run the install script before this, Stow may attempt to take over the entire directory and cause problems.

```sh
mkdir -p "$HOME/.config" "$HOME/.local"
```

Run the following command to clone the dotfiles repository

```bash
git clone --recurse-submodules https://github.com/beckettloose/.dotfiles.git ~/.dotfiles
```

Run the following commands to create the `.zsh_system` file, populate it with the desired modules (adjust as required), and load the environment variables for the initial run of the stow script.

```bash
touch "$HOME/.zsh_system"
echo "export DOTFILES=\"$HOME/.dotfiles\"" >> "$HOME/.zsh_system"
echo "export DOTFILES_STOW_FOLDERS=\"bin,git,nvim,tmux,zsh\"" >> "$HOME/.zsh_system"
source "$HOME/.zsh_system"
```

Now, open the dotfiles directory and run the install script.

```bash
cd ~/.dotfiles
./install
```

### Installing Powerlevel10k (Optional)

If you wish to install Powerlevel10k, run the following command.

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
```

The theme will be automatically loaded next time you log in (or after running `reload`).

## Installing Additional Software (WIP)
