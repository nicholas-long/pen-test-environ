#!/bin/bash

choice=$($HOME/tmux-scripts/parse-searchsploit-csv.sh | fzf --no-hscroll -d ':' --with-nth=2 --preview="$HOME/tmux-scripts/preview.sh {}")
echo $choice
if [ $? == 0 ]; then
  sel=$(echo $choice | cut -d ':' -f 1 | awk '{print $1}' | sed 's/exploits\///g')
  echo "Mirroring $sel"
  pane=$(tmux list-panes | grep active | cut -d ']' -f 3 | awk '{print $1}')
  panepath=$(tmux display-message -t "$pane" -a | grep pane_current_path | cut -d '=' -f 2)
  echo $panepath
  cd $panepath
  sel_length=$(echo -n $sel | wc -c)
  if [ $sel_length != 0 ]; then
    searchsploit -m $sel
    sleep 1
  fi
fi

