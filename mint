#!/usr/bin/env zsh
if [[ -z $STOW_FOLDERS ]]; then
    #STOW_FOLDERS="bin,nvim,personal,tmux,zsh"
    STOW_FOLDERS="bin,nvim,tmux,zsh,zsh_mint_only"
fi

if [[ -z $DOTFILES ]]; then
    DOTFILES=$HOME/.dotfiles
fi

STOW_FOLDERS=$STOW_FOLDERS DOTFILES=$DOTFILES $DOTFILES/install
