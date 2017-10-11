#!/bin/bash

if [ $# -ne 3 ]; then
  echo "usage: binary file1 file2 file_gen_path"
  echo "e.g.: sh get_duplicate.sh bdbk_people.raw bdbk_wxzp.raw duplicate_people_wxzp.txt"
  exit 1
fi

file1=$1
file2=$2
file_gen=$3

export LC_ALL=C

cat $file1 | sort -t'	' -u -k1,1 > .tmp.$file1
cat $file2 | sort -t'	' -u -k1,1 > .tmp.$file2

join --nocheck-order -t'	' -11 -21 -o '1.1,1.2,1.3,1.5,2.2,2.3,2.5' .tmp.$file1 .tmp.$file2 > $file_gen

rm .tmp.$file1
rm .tmp.$file2
