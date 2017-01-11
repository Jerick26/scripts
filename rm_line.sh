#!/bin/sh
# rm_line.sh, remove a line that includes a special string in text

param_list=$*
rm_str=$1
len=${#rm_str}
sub_dir_list=(${param_list[*]:$len})

for x in ${sub_dir_list[*]}
do
  echo "handle ${x} ..."
  sed -i '/'$rm_str'/d' $x
done