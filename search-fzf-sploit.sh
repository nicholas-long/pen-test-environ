#!/bin/bash

choice=$(cat /usr/share/exploitdb/files_exploits.csv | tac | awk -F, '{print $2,"#",$3}' | head -n -1 | column -t -s ',' | fzf --preview="$HOME/tmux-scripts/preview.sh {}")
if [ $? == 0 ]; then
  sel=$(echo $choice | cut -d '#' -f 1 | awk '{print $1}' | sed 's/exploits\///g')
  echo "Mirroring $sel"
  pane='%0'
  panepath=$(tmux display-message -t "$pane" -a | grep pane_current_path | cut -d '=' -f 2)
  echo $panepath
  cd $panepath
  searchsploit -m $sel
  sleep 1
fi

