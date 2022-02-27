#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
KB_DIR=~/GTFOBins.github.io/_gtfobins/

# parse args
PAGING="no"
VERBOSE=0
while [[ $# -gt 0 ]]; do
  case $1 in
    -p|--paging)
      PAGING=1
      ;;
    -v|--verbose)
      VERBOSE=1
      ;;
    -h|--help)
      echo "Usage: $0 -q \"(grep pattern)\" [ options ] kb_directory"
      echo "Options:"
      cat "$0" | grep '^\s\+-.|--.*'
      exit 1
      ;;
    *)
      echo "unknown arg $1"
      ;;
  esac
  shift
done

# exit if parameter is missing
test -z "$KB_DIR" && echo "Missing search path" && exit 1

if [ $VERBOSE -ne 0 ]; then
  echo "KB Dir: $KB_DIR"
  echo "Paging: $PAGING"
fi

# determine from tty size if we should preview vertically or horizontally
rows=$(stty size | awk '{print $1}')
cols=$(stty size | awk '{print $2}')
export WINDOWLOC=up
halfcols=$(( $cols / 2 ))
if (($rows < $halfcols)); then
  export WINDOWLOC=right
fi

getbyname () {
  read file
  [ -z $file ] && exit 1
  if [ $PAGING == "no" ]; then
    bat --color=always --paging=never --style=plain $KB_DIR/$file.md
  else
    bat --color=always --paging=always --style=plain $KB_DIR/$file.md
  fi
}


find $KB_DIR -type f | awk '-F/' '{print $NF}' | cut -d . -f 1 | \
  fzf --preview="bat --color=always --paging=never --style=plain $KB_DIR/{}.md" | \
  getbyname

# grep -v '\.git' | \
