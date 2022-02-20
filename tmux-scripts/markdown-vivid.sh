#!/bin/bash

function draw_bar {
  echo "====================================================================================================" | lolcat
}

function title_bar {
  echo ""
  draw_bar
  figlet -f miniwi "$1" | lolcat
}

function pretty_temp {
  tf=$1
  if [ $? == 0 ]; then
    bat --color=always --paging=never --style=plain --language md $tf
    rm $tf
  fi

}
function prettify {
  tf=$(mktemp)
  IFS=''
  while read -r line; do
    #if echo "$line" | grep '^===|^---' >/dev/null; then
    #  draw_bar
    if echo "$line" | grep '^# ' >/dev/null; then
      ls $tf >/dev/null 2>/dev/null
      pretty_temp $tf
      title_bar "$(echo $line | sed 's/# //g')"
      echo "$line" >> $tf
    else
      echo "$line" >> $tf
    fi
  done
  pretty_temp $tf
}

file=$1
cat $file | prettify
