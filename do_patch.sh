#!/bin/sh

param_list=$*
patch_file=$1

# get sub dir to patch
len=${#patch_file}
sub_dir_list=(${param_list[*]:$len})
# replace file path information
sed -i '1,2s/\(^[-+]\{3\}\) .*\/\(.*\)/\1 \2/g' $patch_file
# do patch
for x in ${sub_dir_list[*]}
do
  echo "patch ${x} ..."
  cd ${x}
  patch -p0 < ../$patch_file
  cd ..
done
