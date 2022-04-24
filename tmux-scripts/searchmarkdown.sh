#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# TODO: -h
# parse args
PAGING="no"
VERBOSE=0
OPTIONAL_MD_SEARCH=""
while [[ $# -gt 0 ]]; do
  case $1 in
    -q|--query) # grep query to find lines
      shift # pop arg
      QUERY="$1"
      ;;
    -p|--paging) # use paging in output
      PAGING=1
      ;;
    -m|--markdown-only) # only show markdown files
      OPTIONAL_MD_SEARCH="grep '\\.md:' | "
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

if [ $VERBOSE -ne 0 ]; then
  echo "search path: $KB_DIR"
  echo "query:       $QUERY"
  echo "paging:      $PAGING"
  [ -z "$OPTIONAL_MD_SEARCH" ] && echo "Searching all files" || \
    echo "Searching only markdown files"
fi

# exit if parameter is missing
test -z "$KB_DIR" && echo "Missing search path" && exit 1
test -z "$QUERY" && echo "Missing query" && exit 1

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
  echo $file
  if [ $PAGING == "no" ]; then
    bat --color=always --paging=never --style=plain $file
  else
    bat --color=always --paging=always --style=plain $file
  fi
  echo ""
  echo "--------------------------------------------------------------------------------"
  echo $file line $line
  echo ""
  awk -v "line=$line" -f $SCRIPT_DIR/print-kb.awk "$file" | bat --language=md --paging=never --style=plain --color=always
}

grep -n -R "$QUERY" "$KB_DIR" 2>/dev/null | \
  sed "s.$KB_DIR/..g" | \
  $OPTIONAL_MD_SEARCH grep -v '\.git' | \
  grep -v '#!' | \
  sed 's/:#\+/:/g' | \
  fzf --preview-window=$WINDOWLOC --delimiter ':' --nth=1,2 --with-nth=1,3 --preview="echo {} | awk -F: '{ print \$2 \": $KB_DIR/\" \$1 }' | xargs -t bat --color=always -r" | \
  awk -F ':' "{print \$2, \"$KB_DIR/\" \$1}" | \
  getbyname $paging
