#!/usr/bin/env zsh
#
# Wrapper to execute the tmux sessionizer script from the zsh line editor. Must
# be accompanied by the following setup code in your zshrc or zsh_profile.
#
# tmux_sessionizer_setup="$HOME/.local/scripts/resources/tmux-sessionizer-setup.zsh"
# if [[ -f "$tmux_sessionizer_setup" ]]; then
#     source "$tmux_sessionizer_setup"
#     bindkey "^f" _tmux-sessionizer
# fi

function _tmux-sessionizer {
    # Restore stdin/out so that tmux attach works when called from a zsh widget
    ( exec </dev/tty; exec <&1; tmux-sessionizer )
    zle .reset-prompt
}

zle -N _tmux-sessionizer
