#!/bin/bash

tf=$(mktemp)
tmux saveb $tf
nvim $tf
head -c -1 $tf | tmux loadb -
rm $tf
