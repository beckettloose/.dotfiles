#!/usr/bin/env zsh

# fzf-ssh
#
# Written by Beckett Loose
#
# zle widget allowing the user to quickly ssh to a specified host by fuzzy
# searching a preconfigured list. It is recommended to bind this to a keyboard
# shortcut for easy access. Requires init code in zshrc/zsh_profile to work.
#
# Currently Broken Features
#   - move zle cursor back to username
#
# Basic config file example:
#
# ---
# config:
#   fzf_options:
#     - "--scheme=default"
#     - "--height=40%"
#     - "--layout=reverse"
#     - "--border"
#     - "--border-label=\"Fuzzy SSH\""
#   defaults:
#     instant: false
#     user: ""
# hosts:
#   - key: "Example Host"
#     host: "192.168.0.1"
#     user: "defaultuser"
#     instant: true
#   - key: "Second Host"
#     host: "192.168.0.2"
#

function _fzf-ssh {
    printf "\33[2K\rfzf-ssh: looking for config file\r"

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

    printf "\33[2K\rfzf-ssh: checking dependencies\r"
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

    printf "\33[2K\rfzf-ssh: parsing config file\r"
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

    # get formatted hosts list and send to fzf, return just the chosen key
    choice=$(yq '.hosts.[] | .key + ": " + .user + "@" + .host' $FUZZY_SSH_CONFIG_FILE | sed 's/"//g' | FZF_DEFAULT_OPTS="$fzf_options" fzf | cut -d":" -f1)

    # ensure choice isn't empty
    if ! [[ -n "$choice" ]]; then
        zle .reset-prompt
        return
    fi

    # check if the host specifies the instant flag
    host_has_instant_key=$(yq ".hosts.[] | select(.key == \"${choice}\") | has(\"instant\")" $FUZZY_SSH_CONFIG_FILE)
    if [[ "$host_has_instant_key" == "true" ]]; then
        # host has instant key, use its value
        instant=$(yq ".hosts.[] | select(.key == \"${choice}\") | .instant" $FUZZY_SSH_CONFIG_FILE)
    else
        # fallback to default instant value
        instant=$(yq ".config.defaults.instant" $FUZZY_SSH_CONFIG_FILE)
    fi

    # check if the host specifies the user parameter
    host_has_user_key=$(yq ".hosts.[] | select(.key == \"${choice}\") | has(\"user\")" $FUZZY_SSH_CONFIG_FILE)
    if [[ "$host_has_user_key" == "true" ]]; then
        # host has user key, use its value
        user=$(yq ".hosts.[] | select(.key == \"${choice}\") | .user" $FUZZY_SSH_CONFIG_FILE | sed 's/"//g')
    else
        # fallback to default user value
        user=$(yq '.config.defaults.user' $FUZZY_SSH_CONFIG_FILE | sed 's/"//g')
    fi

    # get the host parameter
    host=$(yq ".hosts.[] | select(.key == \"${choice}\") | .host" $FUZZY_SSH_CONFIG_FILE | sed 's/"//g')

    # calculate the complete command line string
    if [ -z "${user}" ]; then
        # username is empty, don't print it or the @ symbol
        cmdline="ssh $host"
    else
        # print full username and host
        cmdline="ssh $user@$host"
    fi

    if [[ $instant == "true" ]]; then
        # automatically execute the command
        zle .kill-whole-line
        zle .reset-prompt
        BUFFER="${cmdline}"
        zle .accept-line
        return
    else
        # prepare command but do not execute it
        zle .kill-whole-line
        zle .reset-prompt
        zle -U "${cmdline}"
    fi
}

zle -N _fzf-ssh
