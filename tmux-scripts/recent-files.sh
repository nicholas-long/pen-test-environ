#!/bin/bash

echo -n $(find / -type f 2>/dev/null | xargs ls -al --full-time 2>/dev/null | awk '{print $6, $7, "|", $9}' | sed 's/ | /|/g' | grep -v '^ |$' | sort | tac | fzf | cut -d '|' -f 2) | tmux loadb -

# get current pane
#pane=$(tmux list-panes | grep active | cut -d ']' -f 3 | awk '{print $1}')

# get working directory of pane
#panepath=$(tmux display-message -t "$pane" -a | grep pane_current_path | cut -d '=' -f 2)

