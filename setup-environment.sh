#!/bin/bash

echo "installing prerequisites"
sudo apt install -y git fzf neovim tmux figlet

echo "initialize neovim config dir"
mkdir -p $HOME/.config/nvim

echo "set up symlinks"
ln -s $(pwd)/functions.sh $HOME/functions.sh
ln -s $(pwd)/tmux-scripts $HOME/tmux-scripts
ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/neovim-bindings.vim $HOME/.config/nvim/init.vim
ln -s $(pwd)/gruvbox.dircolors $HOME/.dircolors
ln -s $(pwd)/alacritty.yml $HOME/.alacritty.yml

echo set up neovim plugins
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
nvim -c ':PluginInstall' -c ':q' -c ':q'

echo "installing fff"
git clone https://github.com/dylanaraps/fff
cd fff
sudo cp fff /usr/bin/
cd -
rm -rf fff

echo "install into bashrc"
echo "source ~/functions.sh" >> ~/.bashrc

echo "install bat"
sudo dpkg -i bat*.deb

echo "install figlet fonts"
sudo bash -c 'mkdir -p /usr/share/figlet && cd /usr/share/figlet && git clone https://github.com/xero/figlet-fonts && mv figlet-fonts/* .'

echo "install lazygit"
mkdir unzip
cp lazy*.tar.gz unzip/
cd unzip/
tar -xzvf lazy*.tar.gz
sudo cp lazygit /usr/bin
cd -
rm -rf unzip/
