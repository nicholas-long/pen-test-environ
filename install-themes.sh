#!/bin/bash

wget https://raw.githubusercontent.com/sbugzu/gruvbox-zsh/master/gruvbox.zsh-theme
wget https://raw.githubusercontent.com/agnoster/agnoster-zsh-theme/master/agnoster.zsh-theme
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# add the following to ~/.zshrc and uncomment
#source /home/kali/functions.sh
#source /home/kali/pen-test-environ/gruvbox.zsh-theme
#source /home/kali/pen-test-environ/agnoster.zsh-theme
