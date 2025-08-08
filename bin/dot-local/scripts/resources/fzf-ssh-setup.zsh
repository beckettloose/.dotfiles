#!/usr/bin/env zsh

# fzf-ssh
#
# Written by Beckett Loose
#
# zle widget allowing the user to quickly ssh to a specified host by fuzzy
# searching a list from a configuration file. It is recommended to bind this
# to a keyboard shortcut for easy access
#
# Currently Broken Features
#   - handle default user name
#   - move zle cursor back to username

function _fzf-ssh {
    printf "\33[2K\rLoading fzf-ssh...\r"

    # Set default config file location if not already set
    if [[ -z $FUZZY_SSH_CONFIG_FILE ]]; then
        FUZZY_SSH_CONFIG_FILE="$HOME/.fzf-ssh.yaml"
    fi

    if [[ -f $FUZZY_SSH_CONFIG_FILE ]]; then
        :
    elif [[ -L $FUZZY_SSH_CONFIG_FILE ]]; then
        :
    else
        echo "\nfatal: specified config file does not exist!"
        zle .reset-prompt
        return
    fi

    # Check that yq exists
    if ! type "yq" > /dev/null; then
        echo "\nfatal: yq not in current path! is it installed?"
        zle .reset-prompt
        return
    fi

    # Check that fzf exists
    if ! type "fzf" > /dev/null; then
        echo "\nfatal: fzf not in current path! is it installed?"
        zle .reset-prompt
        return
    fi

    # Make sure the 'hosts' key exists in the config file
    if [[ "$(yq '. | has("hosts")' $FUZZY_SSH_CONFIG_FILE)" == "true" ]]; then
        :
    else
        echo "\nfatal: config file does not contain top level key 'hosts'"
        zle .reset-prompt
        return
    fi

    # If the user provided custom fzf options, apply them
    if [[ "$(yq '.config | has("fzf_options")' $FUZZY_SSH_CONFIG_FILE)" == "true" ]]; then
        fzf_options=$(yq -r ".config.fzf_options.[]" $FUZZY_SSH_CONFIG_FILE | tr '\n' ' ')
    else
        fzf_options="--height 40% --layout reverse --border --border-label=\"Fuzzy SSH\""
    fi

    # get hosts and send to fzf
    # choice=$(yq -r ".hosts.[]" $FUZZY_SSH_CONFIG_FILE | FZF_DEFAULT_OPTS="--height 40% --layout reverse --border --border-label=\"Fuzzy SSH\"" fzf)
    choice=$(yq ".hosts.[]" $FUZZY_SSH_CONFIG_FILE | FZF_DEFAULT_OPTS="$fzf_options" fzf)

    # make sure we selected something
    if ! [[ -n "$choice" ]]; then
        zle .reset-prompt
        return
    fi

    instant=$(yq ".config.defaults.instant" $FUZZY_SSH_CONFIG_FILE)

    if [[ $instant == "true" ]]; then
        zle .kill-whole-line
        zle .reset-prompt
        BUFFER="ssh $choice"
        zle .accept-line
        return
    else
        zle .kill-whole-line
        zle .reset-prompt
        zle -U "ssh ${choice}"
    fi
}

zle -N _fzf-ssh
