#!/bin/bash

git pull
if [ $? != 0 ]; then
  exit 1
fi

cd tmux-scripts
git clone https://github.com/dylanaraps/fff
git clone https://github.com/nicholas-long/github-exploit-code-repository-index
git clone https://github.com/nicholas-long/tmux-pwn-menu
cd -

docker build . -t environ
if [ $? != 0 ]; then
  exit 1
fi

docker run --rm -it \
  -v "$HOME/.git-credentials:/home/coyote/.git-credentials:ro" \
  -v "$HOME/.gitconfig:/home/coyote/.gitconfig" \
  -v "$(pwd):/home/coyote/environ" \
  -v "$(pwd)/tmux-scripts:/home/coyote/tmux-scripts" \
  -e "TERM=xterm-256color" \
  environ

docker system prune -a -f

