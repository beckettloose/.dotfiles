#!/usr/bin/env zsh

function _tmux-sessionizer {
    # Restore stdin/out so that tmux attach works when called from a zsh widget
    ( exec </dev/tty; exec <&1; tmux-sessionizer )
    zle .reset-prompt
}

zle -N _tmux-sessionizer
