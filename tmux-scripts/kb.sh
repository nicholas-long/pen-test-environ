#!/bin/bash

getbyname () {
  read line file
  tail -n +$line $file | grep '^```' -A 9999999 | tail -n +2 | grep '^```$' -B 9999999 | head -n -1
}

grep -n -R '^#' ~/kb 2>/dev/null | grep -v '\.git' | grep -v '#!' | sed 's/:#\+/:/g' | fzf --delimiter ':' --nth=1,2 --with-nth=3 | awk -F ':' '{print $2, $1}' | getbyname

