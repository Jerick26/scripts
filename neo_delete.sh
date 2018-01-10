#!/bin/bash

neo4j_url=
label=
echo "authorization:"
read -s autho

declare -a names=(
"苹果公司"
"谷歌公司"
)

declare -a ids=(
"26f6e8e19fd033684d673ba17dc23305"
"099811281ab76ae277175fc4276582f8"
)

for (( i=0; i<${#names[@]}; i++ )); do
  echo "process name: ${names[$i]}"
  # check whether in databases
  curl -s -o tmp.json -X POST -H "Accept: application/json; charset=UTF-8" -H "Content-Type: application/json" -H "Authorization:'"$autho"'" $neo4j_url -d '{
    "query" : "match (n:`'$label'` {name: {name} }) return n",
    "params" : {
      "name": "'"${names[$i]}"'"
    }
  }'
  grep "metadata" tmp.json > /dev/null
  #count=`wc -l tmp.json | awk '{print $1}'`
  if [ $? -ne 0 ]; then
    echo "node not existed in databases, name: ${names[$i]}"
    continue
  fi
  # import data
  curl -s -o result.json -X POST -H "Accept: application/json; charset=UTF-8" -H "Content-Type: application/json" -H "Authorization:'"$autho"'" $neo4j_url -d '{
    "query" : "match (n:`'$label'` {id: {id}, name: {name}} ) detach delete n",
    "params" : {
      "id": "'"${ids[$i]}"'",
      "name":"'"${names[$i]}"'"
    }
  }'
  grep "errors" result.json > /dev/null
  if [ $? -eq 0 ]; then
    echo "fail to delete node, name: ${names[$i]}"
  fi
done
