#!/usr/bin/env zsh

function _fzf-git-switch {
    printf "\33[2K\r" # Clear the prompt line so prints are displayed better

    # make sure we are in a git repo
    if ! git rev-parse --is-inside-work-tree > /dev/null; then
        zle .reset-prompt
        return
    fi

    branches=()
    typeset -aU branches # auto-deduplicate branch list
    fzf_label="Fuzzy Git Switch (Local Branches Only)"

    if [[ $1 = "all" ]]; then
        # override fzf label when searching all branches
        fzf_label="Fuzzy Git Switch (Include Remotes)"
        # get all branches from remotes (and deduplicate, assuming one primary remote)
        printf "fzf-git-switch: finding remote branches\r"
        for j in $(git ls-remote -q --heads | awk '{print $2;}' | sed 's/^refs\/heads\///'); do
            if [[ ! " ${branches[*]} " =~ [[:space:]]${j}[[:space:]] ]]; then
                branches+=("${j}");
            fi
        done
    fi

    # find local branches only (preferred when possible to avoid network access)
    printf "fzf-git-switch: finding local branches\r"
    for i in $(git branch --format "%(refname:short)" | sed '/[[:space:]]/d'); do
        branches+=("$i")
    done

    choice=$(printf "%s\n" "${branches[@]}" | fzf --height 40% --layout reverse --border --border-label="${fzf_label}")

    if [[ -n "$choice" ]]; then
        if [[ $1 = "all" ]]; then
            # Fetch any new branches from remotes. This is required because the
            # remote query did not actually fetch those branches
            printf "fzf-git-switch: fetching from remotes\n"
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
