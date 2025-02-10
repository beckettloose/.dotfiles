#!/usr/bin/env sh

selected=$(cat ~/.local/scripts/tmux-cht-languages ~/.local/scripts/tmux-cht-command | fzf)

if [ -z "$selected" ]; then
    exit 1
fi

printf "Enter Query (or blank for all results): "
read -r query

if grep -qs "$selected" ~/.tmux-cht-languages; then
    query=$(echo "$query" | tr ' ' '+')
    curl "cheat.sh/$selected/$query/\"" & curl -s "cheat.sh/$selected/$query" | less
else
    curl -s "cheat.sh/${selected}~${query}" | less
fi

