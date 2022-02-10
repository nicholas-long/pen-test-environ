#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

menuitems() {
  echo "Knowledge base search:$SCRIPT_DIR/kb.sh"
  echo "Exploit search:$SCRIPT_DIR/exploit-search-init.sh"
  echo "Reverse shell kit:$SCRIPT_DIR/tmux-pwn-menu/tmux-pwn-menu.py"
  echo "Manage files:$SCRIPT_DIR/fff/fff"
  echo "Start Apache:sudo systemctl start apache2"
  echo "Stop Apache:sudo systemctl stop apache2"
  echo "Copy file path to tmux:$SCRIPT_DIR/recent-files.sh"
  echo "Help:bat --color=always -pp $SCRIPT_DIR/hotkeys.md | less -R"
}

choice=$(menuitems | fzf -d ':' --nth=1 --with-nth=1 | cut -d ':' -f 2)
if [ $(echo -n "$KB_DIR" | wc -c) == 0 ]; then
  bash -c $choice
fi

