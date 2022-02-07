#!/bin/bash

input=$1
file=$(echo $input | cut -d ':' -f 1 | awk '{print $1}')

bat --color=always "$file"
