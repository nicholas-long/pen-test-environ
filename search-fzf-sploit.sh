#!/bin/bash

cat /usr/share/exploitdb/files_exploits.csv | tac | awk -F, '{print $2,"#",$3}' | head -n -1 | column -t -s ',' | fzf --preview="~/tmux-scripts/preview.sh {}"

