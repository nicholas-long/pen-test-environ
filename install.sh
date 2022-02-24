#!/bin/bash

cp tmux.conf ~/.tmux.conf
cp neovim-bindings.vim ~/.config/nvim/init.vim
sudo apt install fonts-powerline

mkdir -p ~/tmux-scripts
cp -r tmux-scripts/* ~/tmux-scripts/ 2>/dev/null
cd ~/tmux-scripts && git clone https://github.com/dylanaraps/fff 2>/dev/null && git clone https://github.com/nicholas-long/github-exploit-code-repository-index 2>/dev/null

