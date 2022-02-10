#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

KB_DIR=$(cat $SCRIPT_DIR/kb_locations.lst | fzf "--preview=bat --color=always {}/README.md")

getbyname () {
  read line file
  tail -n +$line $file | $SCRIPT_DIR/get-markdown-snippet.py
}

grep -n -R '^#' $KB_DIR 2>/dev/null | grep -v '\.git' | grep -v '#!' | sed 's/:#\+/:/g' | fzf --delimiter ':' --nth=1,2 --with-nth=3 --preview='echo {} | cut -d ':' -f 1 | xargs bat --color=always' | awk -F ':' '{print $2, $1}' | getbyname

