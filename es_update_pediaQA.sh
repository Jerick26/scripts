#!/bin/bash

ids=(
#"f78663a9cb07f5cac991821d31766786"
#"18b6607182f5a70c6903a6548b9c209a"
#"8cfe4a5f1d950dda479256ddf556e9f5"
#"28034d4326cb83b2303cca86e2ded5f2"
"cae07f20dfae81cca4e9eda7724cff8b"
)

for id in ${ids[*]}; do
  curl -XPOST http://192.168.1.43:9200/pd_baike/baike/$id/_update  -d '
  {
    "doc" : {
      "pv": 933467
    }
  }'
  echo ""
done
