#!/usr/bin/env zsh
#
# Wrapper to execute the tfuz script from the zsh line editor. Must be
# accompanied by the following setup code in your zshrc or zsh_profile.
#
# tmux_tfuz_setup="$HOME/.local/scripts/resources/tmux-tfuz-setup.zsh"
# if [[ -f "$tmux_tfuz_setup" ]]; then
#     source "$tmux_tfuz_setup"
#     bindkey "^[f" _tmux-tfuz
# fi

function _tmux-tfuz {
    # Restore stdin/stdout so that tmux attach works when called from a zsh widget
    ( exec </dev/tty; exec <&1; tfuz)
    zle .reset-prompt
}

zle -N _tmux-tfuz
