#!/bin/bash

docker build . -t environ
docker run --rm -it \
  -v "$HOME/.git-credentials:/home/coyote/.git-credentials:ro" \
  -v "$HOME/.gitconfig:/home/coyote/.gitconfig" \
  -v "$(pwd):/host" \
  -e "TERM=xterm-256color" \
  environ
