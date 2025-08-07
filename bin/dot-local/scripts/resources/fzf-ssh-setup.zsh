#!/usr/bin/env zsh

# fzf-ssh
#
# Written by Beckett Loose
#
# Allows the user to quickly ssh to a specified host by fuzzy searching a list
# from a configuration file. It is recommended to bind this to a keyboard
# shortcut for easy access
#
# To Debug: DEBUG=1 fzf-ssh
#
# Currently Broken Features
#   - validate config file before execution
#   - use custom fzf options
#   - handle default user name
#   - move zle cursor back to username

function _fzf-ssh {
    # Set default config file location if not already set
    if [[ -z $FUZZY_SSH_CONFIG_FILE ]]; then
        FUZZY_SSH_CONFIG_FILE="$HOME/.fzf-ssh.yaml"
    fi

    if [[ -f $FUZZY_SSH_CONFIG_FILE ]]; then
        :
    elif [[ -L $FUZZY_SSH_CONFIG_FILE ]]; then
        :
    else
        echo "fatal: specified config file does not exist!"
        zle .reset-prompt
        return
    fi

    # Check that yq exists
    if ! type "yq" > /dev/null; then
        echo "fatal: yq not in current path! is it installed?"
        zle .reset-prompt
        return
    fi

    # Check that fzf exists
    if ! type "fzf" > /dev/null; then
        echo "fatal: fzf not in current path! is it installed?"
        zle .reset-prompt
        return
    fi

    fzf_options=$(yq -r ".config.fzf_options.[]" $FUZZY_SSH_CONFIG_FILE | tr '\n' ' ')

    # get hosts and send to fzf
    choice=$(yq -r ".hosts.[]" $FUZZY_SSH_CONFIG_FILE | FZF_DEFAULT_OPTS="--height 40% --layout reverse --border --border-label=\"Fuzzy SSH\"" fzf)

    # make sure we selected something
    if ! [[ -n "$choice" ]]; then
        echo "fatal: no host selected"
        zle .reset-prompt
        return
    fi

    instant=$(yq ".config.defaults.instant" $FUZZY_SSH_CONFIG_FILE)

    if [[ $instant == "true" ]]; then
        echo "Selected Host: $choice"
        ssh "$choice"
    else
        zle .kill-whole-line
        zle .reset-prompt
        zle -U "ssh ${choice}"
    fi
}

zle -N _fzf-ssh
