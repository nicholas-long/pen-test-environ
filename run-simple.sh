#!/bin/bash

docker build . -t environ
if [ $? != 0 ]; then
  exit 1
fi

docker run --rm -it \
  -e "TERM=xterm-256color" \
  environ
