#!/bin/bash

tf=$(mktemp)
tmux saveb $tf
nvim $tf
tmux loadb $tf
rm $tf
