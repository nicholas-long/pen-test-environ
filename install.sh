#!/bin/bash

mkdir -p ~/tmux-scripts
cp parse-searchsploit-csv.sh search-fzf-sploit.sh preview.sh ~/tmux-scripts

cp tmux.conf ~/.tmux.conf
cp neovim-bindings.vim ~/.config/nvim/init.vim

#rm -rf ~/tmux-scripts
cp -r tmux-scripts/* ~/tmux-scripts/

cd ~/tmux-scripts && git clone https://github.com/dylanaraps/fff && git clone https://github.com/nicholas-long/github-exploit-code-repository-index

