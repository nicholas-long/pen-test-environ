#!/bin/bash

wget https://raw.githubusercontent.com/sbugzu/gruvbox-zsh/master/gruvbox.zsh-theme
wget https://raw.githubusercontent.com/agnoster/agnoster-zsh-theme/master/agnoster.zsh-theme
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# add to ~/.zshrc
cat ~/tmux-scripts/kali-stuff-to-add-to-zsh.rc >> ~/.zshrc
