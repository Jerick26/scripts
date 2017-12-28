#!/bin/bash

#set -x
function is_git_dir {
  git rev-parse --is-inside-work-tree &> /dev/null
}

function get_branch {
  if is_git_dir
  then
    local BR=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD 2> /dev/null)
    if [ "$BR" == HEAD ]
    then
      local NM=$(git name-rev --name-only HEAD 2> /dev/null)
      if [ "$NM" != undefined ]; then
        echo -n "$NM"
      else
        git rev-parse --short HEAD 2> /dev/null
      fi
    else
      echo -n "$BR"
    fi
  fi
}

if [ $# -ne 5 ]; then
  echo "usage: binary dev|test|online project branch commit verNo"
  exit 1
fi
echo "command: $0 $@"

env=$1
proj=$2
branch=$3
commit=$4
verNo=$5
if [[ $env != dev ]] && [[ $env != test ]] && [[ $env != online ]]; then
  echo "wrong environment set, expect to be dev, test, online"
  exit 1
fi
proj_dir=$HOME/go/src/roobo.com/$proj
tool_dir=$HOME/tools/deploy
output=/aicloud/output

if [ ! -d $proj_dir ]; then
  echo "directory not existed for $proj_dir"
  exit 1
fi

cd $proj_dir

# update source code
git reset --hard HEAD
git checkout master
git fetch origin 
git merge origin/master
git branch build_$branch origin/$branch 2> /dev/null
ret=$?
if [ $ret -ne 0 ] && [ $ret -ne 128 ]; then
  echo "failed to branchout build_$branch"
  exit 1
fi
git checkout build_$branch 2> /dev/null
git merge origin/$branch
# check branch valid
BR=$(get_branch)
if [[ $BR != build_$branch ]]; then
  echo "undefined branch for $branch"
  exit 1
fi
# update commit
if [[ $commit != "" ]] && [ $commit != '0' ]; then
  git checkout $commit 2> /dev/null
  if [ $? -ne 0 ]; then
    echo "failed to checkout commit: $commit"
    exit 1
  fi
  echo "checkout to commit: $commit"
else
  echo "checkout to HEAD"
fi
# build project
sh AIMAKE $env
if [ $? -ne 0 ]; then
  echo "AIMAKE $env failed!"
  exit 1
fi
# make tar package
target=$proj.$branch.$verNo.tar.gz
outfile=$output/$target
echo "start to archive $target"
cd "$env"_stagging
# write version
echo $target > version.txt 
md5sum $proj >> version.txt 
md5sum conf/* >> version.txt
# tar packet
tar zcf $outfile .
# end
echo -n "$outfile"
echo
exit 0
