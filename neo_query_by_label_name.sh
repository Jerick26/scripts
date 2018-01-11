#!/bin/bash

program=$0

usage() {
  echo "sh $program label names[...]"
  echo "example:\nsh $program 人物  刘德华 张学友"
}

if [ $# -le 1 ]; then
  usage
  exit 1
fi

if [[ ( $# == "--help") ||  $# == "-h" ]]; then
  usage
  exit 1
fi

label=$1
names="${@:2}"

neo4j_url="http://127.0.0.1:7474/db/data/cypher"
#echo "authorization:"
#read -s autho

#for (( i=0; i<${#names[@]}; i++ )); do
for name in "${@:2}"; do
  echo "query name: $name"
  # check whether in databases
  curl -s -X POST -H "Accept: application/json; charset=UTF-8" -H "Content-Type: application/json" -H "Authorization:'"$autho"'" $neo4j_url -d '{
    "query" : "match (n:`'$label'` {name: {name} }) return n order by n.PV desc",
    "params" : {
      "name": "'"$name"'"
    }
  }'
  echo "\n\n=============================\n=============================\n"
done
