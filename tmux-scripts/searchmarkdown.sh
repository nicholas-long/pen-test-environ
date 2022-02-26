#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# TODO: -h
# parse args
PAGING="no"
VERBOSE=0
while [[ $# -gt 0 ]]; do
  case $1 in
    -q|--query)
      shift # pop arg
      QUERY="$1"
      ;;
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
      KB_DIR="$1"
      ;;
  esac
  shift
done

# exit if parameter is missing
test -z "$KB_DIR" && echo "Missing search path" && exit 1
test -z "$QUERY" && echo "Missing query" && exit 1

if [ $VERBOSE -ne 0 ]; then
  echo "KB Dir: $KB_DIR"
  echo "Query:  $QUERY"
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
  read line file
  if [ $PAGING == "no" ]; then
    bat --color=always --paging=never --style=plain $file
  else
    bat --color=always --paging=always --style=plain $file
  fi
}

grep -n -R "$QUERY" "$KB_DIR" 2>/dev/null | \
  grep '\.md:' | \
  grep -v '\.git' | \
  grep -v '#!' | \
  sed 's/:#\+/:/g' | \
  fzf --preview-window=$WINDOWLOC --delimiter ':' --nth=1,2 --with-nth=1,3 --preview="echo {} | sed 's/\(.*\):\([0-9]\+\):.*/\2: \1/g' | xargs -t bat --color=always -r" | \
  awk -F ':' '{print $2, $1}' | \
  getbyname $paging