#!/usr/bin/env zsh

function _fzf-git-switch {
    printf "\33[2K\r" # Clear the prompt line so prints are displayed better

    # make sure we are in a git repo
    if ! git rev-parse --is-inside-work-tree > /dev/null; then
        zle .reset-prompt
        return
    fi

    branches=()

    if [[ $1 = "all" ]]; then
        # get all local branches without upstreams
        fzf_label="Fuzzy Git Switch (Include Remotes)"
        printf "Finding local branches...\r"
        for i in $(git branch --format "%(refname:short) %(upstream)" | awk '{if (!$2) print $1;}'); do
            branches+=("$i");
        done

        # get all branches from remotes (and deduplicate)
        printf "Finding remote branches...\r"
        for j in $(git ls-remote -q --heads | awk '{print $2;}' | sed 's/^refs\/heads\///'); do
            if [[ ! " ${branches[*]} " =~ [[:space:]]${j}[[:space:]] ]]; then
                branches+=("${j}");
            fi
        done
    else
        # find local branches only (better performance since no network access)
        fzf_label="Fuzzy Git Switch (Local Branches Only)"
        printf "Finding local branches...\r"
        for i in $(git branch --format "%(refname:short)" | sed '/[[:space:]]/d'); do
            branches+=("$i")
        done
    fi

    choice=$(printf "%s\n" "${branches[@]}" | fzf --height 40% --layout reverse --border --border-label="${fzf_label}")

    if [[ -n "$choice" ]]; then
        if [[ $1 = "all" ]]; then
            # Fetch any new branches from remotes.
            printf "Fetching from remotes...\n"
            git fetch
        fi
        git switch "$choice"
        zle .reset-prompt
        redraw_p10k_prompt # only required if HEAD changes
        return
    else
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
