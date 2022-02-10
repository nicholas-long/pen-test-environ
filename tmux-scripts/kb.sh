#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

KB_DIR=$(cat $SCRIPT_DIR/kb_locations.lst | fzf "--preview=bat --color=always {}/README.md")
if [ $(echo -n "$KB_DIR" | wc -c) == 0 ]; then 
  exit 1
fi

getbyname () {
  read line file
  tail -n +$line $file | $SCRIPT_DIR/get-markdown-snippet.py
}

grep -n -R '^#' $KB_DIR 2>/dev/null | grep -v '\.git' | grep -v '#!' | sed 's/:#\+/:/g' | fzf --delimiter ':' --nth=1,2 --with-nth=1,3 --preview="echo {} | sed 's/\(.*\):\([0-9]\+\):.*/\2: \1/g' | xargs -t bat --color=always -r" | awk -F ':' '{print $2, $1}' | getbyname

