#!/bin/sh
# ch_line.sh, replace a line that includes a special string witch a input string

param_list=$*
rm_str=$1
new_str=$2

len=${#rm_str}
len=$[${#new_str} + $len + 1]
sub_dir_list=(${param_list[*]:$len})

for x in ${sub_dir_list[*]}
do
  echo "handle ${x} ..."
  sed -i 's/'$rm_str'/'$new_str'/g' $x
done