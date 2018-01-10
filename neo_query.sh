#!/bin/bash

neo4j_url="http://127.0.0.1:7474/db/data/cypher"
#autho="bmVvNGo6bmVvNGo="
label="社会_组织机构_企业"
echo "authorization:"
read -s autho

declare -a names=(
"苹果公司"
"谷歌公司"
)

for (( i=0; i<${#names[@]}; i++ )); do
  echo "process name: ${names[$i]}"
  # check whether in databases
  curl -s -X POST -H "Accept: application/json; charset=UTF-8" -H "Content-Type: application/json" -H "Authorization:'"$autho"'" $neo4j_url -d '{
    "query" : "match (n:`'$label'` {name: {name} }) return n",
    "params" : {
      "name": "'"${names[$i]}"'"
    }
  }'
done
