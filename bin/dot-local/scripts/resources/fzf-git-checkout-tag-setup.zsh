#!/usr/bin/env zsh

# Allow the user to fuzzy find a git tag, then check it out. Works as a zsh line
# editor (zle) widget, and must be accompanied by the following setup code in
# your zshrc or zsh_profile.
#
# fzf_git_checkout_tag_setup="$HOME/.local/scripts/resources/fzf-git-checkout-tag-setup.zsh"
# if [[ -f "$fzf_git_checkout_tag_setup" ]]; then
#     source "$fzf_git_checkout_tag_setup"
#     bindkey "^[t" _fzf-git-checkout-tag
# fi

function _fzf-git-checkout-tag {
    printf "\33[2K\r" # Clear the prompt line so prints are displayed better

    # make sure we are in a git repo
    if ! git rev-parse --is-inside-work-tree > /dev/null; then
        zle .reset-prompt
        return
    fi

    tags=()

    # find all tags present locally. we won't fetch here to save performance
    fzf_label="Fuzzy Git Tag Checkout"

    for i in $(git tag --sort=-v:refname -n --list "${1}*" | awk '{print $1}'); do
        tags+=("$i")
    done

    # exit if this repo doesn't have any tags
    if [ -z "$tags" ]; then
        printf "\33[2K\r"
        zle .reset-prompt
        return
    fi

    choice=$(printf "%s\n" "${tags[@]}" | fzf --height 40% --layout reverse --border --border-label="${fzf_label}")

    if [[ -n "$choice" ]]; then
        git checkout "refs/tags/${choice}"
        zle .reset-prompt
        redraw_p10k_prompt # only required if HEAD changes
        return
    else
        zle .reset-prompt
        return
    fi
}

zle -N _fzf-git-checkout-tag
