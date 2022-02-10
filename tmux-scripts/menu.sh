#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

menuitems() {
  echo "$SCRIPT_DIR/kb.sh:exploit search"
  echo "$SCRIPT_DIR/tmux-pwn-menu/tmux-pwn-menu.py:reverse shell kit"
  echo "$SCRIPT_DIR/fff/fff:manage files"
}

choice=$(menuitems | fzf -d ':' --nth=1 --with-nth=2 | cut -d ':' -f 1)
if [ $(echo -n "$KB_DIR" | wc -c) == 0 ]; then
  $choice
fi

