#!/bin/bash

#! /bin/bash
while IFS="," read -r recordid filename title bad_date author exploittype platform
do
  echo "/usr/share/exploitdb/$filename:$title $author $platform $filename"
done < <(tac /usr/share/exploitdb/files_exploits.csv | head -n -1)

