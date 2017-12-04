#!/bin/bash

set -x

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

if [ $# -lt 2 ]; then
  echo "usage: binary project branch [commit]"
  exit 1
fi

proj=$1
branch=$2
commit=$3
proj_dir=$HOME/go/src/roobo.com/$proj
tool_dir=$HOME/tools/deploy
output=/aicloud/output

if [ ! -d $proj_dir ]; then
  echo "directory not existed for $proj_dir"
  exit 1
fi

cd $proj_dir

git checkout master
git fetch origin 
git branch build_$branch origin/$branch 2> /dev/null
ret=$?
if [ $ret -ne 0 ] && [ $ret -ne 128 ]; then
  echo "failed to branchout build_$branch"
  exit 1
fi
git checkout build_$branch 2> /dev/null

BR=$(get_branch)
if [[ $BR != build_$branch ]]; then
  echo "undefined branch for $branch"
  exit 1
fi

if [[ $commit != "" ]]; then
  git checkout $commit 2> /dev/null
  if [ $? -ne 0 ]; then
    echo "failed to checkout commit: $commit"
    exit 1
  fi
fi

go build -a
if [ $? -ne 0 ]; then
  echo "build error"
  exit 1
fi

outfile=$output/$proj.$branch.tar.gz
mkdir log 2> /dev/null
cp $tool_dir/{control.func,control.inc,"$proj"_control,supervise.$proj} .
tar zcf $outfile $proj conf log control.func control.inc "$proj"_control supervise.$proj
rm control.func control.inc "$proj"_control supervise.$proj

echo -n $outfile
