#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# determine from tty size if we should preview vertically or horizontally
rows=$(stty size | awk '{print $1}')
cols=$(stty size | awk '{print $2}')
export WINDOWLOC=up
halfcols=$(( $cols / 2 ))
if (($rows < $halfcols)); then
  export WINDOWLOC=right
fi

paging=$1

KB_DIR=$(cat $SCRIPT_DIR/kb_locations.lst | fzf --preview-window=$WINDOWLOC "--preview=bat --color=always {}/README.md")
if [ $(echo -n "$KB_DIR" | wc -c) == 0 ]; then 
  exit 1
fi

getbyname () {
  read line file
  if [ $paging == "no" ]; then
    bat --color=always --paging=never --style=plain $file
  else
    bat --color=always --paging=always --style=plain $file
  fi
}

grep -n -R '^#' $KB_DIR 2>/dev/null | grep -v '\.git' | grep -v '#!' | sed 's/:#\+/:/g' | fzf --preview-window=$WINDOWLOC --delimiter ':' --nth=1,2 --with-nth=1,3 --preview="echo {} | sed 's/\(.*\):\([0-9]\+\):.*/\2: \1/g' | xargs -t bat --color=always -r" | awk -F ':' '{print $2, $1}' | getbyname $paging

