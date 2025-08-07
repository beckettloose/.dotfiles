#!/usr/bin/env zsh

function _fzf-git-switch {
    printf "\n" # make sure errors don't show up on the prompt line

    # make sure we are in a git repo
    if ! git rev-parse --is-inside-work-tree > /dev/null; then
        zle .reset-prompt
        return
    fi

    # create empty array to store branches
    branches=()

    if [[ $1 = "all" ]]; then
        fzf_label="Fuzzy Git Switch (With Remotes)"
        # get all local branches without upstreams
        printf "Finding local branches...\r"
        for i in $(git branch --format "%(refname:short) %(upstream)" | awk '{if (!$2) print $1;}'); do
            branches+=("$i");
        done

        # get all branches from remotes (deduplicated)
        printf "Finding remote branches... this may take a while (make sure all remotes are reachable)\r"
        for j in $(git ls-remote -q --heads | awk '{print $2;}' | sed 's/^refs\/heads\///'); do
            if [[ ! " ${branches[*]} " =~ [[:space:]]${j}[[:space:]] ]]; then
                branches+=("${j}");
            fi
        done
    else
        fzf_label="Fuzzy Git Switch (Local Only)"
        # find local branches only (for performance)
        printf "Finding local branches...\r"
        for i in $(git branch --format "%(refname:short)"); do
            branches+=("$i")
        done
    fi

    # send to fzf
    choice=$(printf "%s\n" "${branches[@]}" | fzf --height 40% --layout reverse --border --border-label="${fzf_label}")

    # execute switch if branch was provided
    if [[ -n "$choice" ]]; then
        # Fetch new branches from remotes.
        printf "Fetching from remotes...\n"
        git fetch
        git switch "$choice"
    else
        echo "fatal: no branch selected"
        zle .reset-prompt
        return
    fi
}

function _fzf-git-switch-all ()
{
    zle _fzf-git-switch all
}

zle -N _fzf-git-switch
zle -N _fzf-git-switch-all
