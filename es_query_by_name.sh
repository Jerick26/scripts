#!/bin/bash

program=$0

usage() {
  echo "sh $program names[...]"
  echo "example:\nsh $program  刘德华 张学友"
}

if [ $# -eq 0 ]; then
  usage
  exit 1
fi

if [[ ( $# == "--help") ||  $# == "-h" ]]; then
  usage
  exit 1
fi

es_url="http://127.0.0.1:9200/pd_baike/baike/_search?pretty=true&size=10"

for name in $@; do
  curl -s -X POST -H "Accept: application/json; charset=UTF-8" -H "Content-Type: application/json" $es_url -d '{
    "query":{"constant_score":{"filter":{"bool":{"must":[{"terms":{
      "title":["'"$name"'"]
      }}]}}}},
      "sort":[{"pv":{"order":"desc","mode":"max","unmapped_type":"long","missing":"_last"}}]
    }'
  echo "\n=============================\n=============================\n"
done
