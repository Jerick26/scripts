#!/bin/bash

neo4j_url="http://127.0.0.1:7474/db/data/cypher"
#autho="bmVvNGo6bmVvNGo="
label="社会_组织机构_企业"
echo "authorization:"
read -s autho

declare -a names=(
"苹果公司"
"谷歌公司"
#"亚马逊"
#"腾讯"
#"阿里巴巴集团"
#"百度"
#"美团网"
#"北京小米科技有限责任公司"
#"联想集团"
#"华为技术有限公司"
#"京东"
)

declare -a ids=(
"26f6e8e19fd033684d673ba17dc23305"
"099811281ab76ae277175fc4276582f8"
"dbd79683c84ecdb0d9d82fa0b1ab0d6d"
"31adc41e5fc7c5c1ac7d4734e881e69c"
"cde73ef60954e5b0f3f6fe557d29db06"
"90317f3f3e3480e64a33beea6c53b1e7"
"cfdac59d034ac8c50555db176c014e95"
"e275618efe33f7beaee1d5221d659f59"
"4a346911a95afcef9aaa9f4def0140a8"
"279d7fffd23e1e3e3cf2310ef3849483"
"783ec479471d20b9b2ac05571d7c5fb4"
)

declare -a pvs=(
7479368
10205726
2461846
6283459
7475337
31320847
2480167
5073404
2174221
4729755
5360251
)

declare -a values=(
"蒂姆·库克，1960年11月1日出生于美国阿拉巴马州，现任苹果公司首席执行官。"
"埃里克·施密特，1955年出生，谷歌前CEO、著名电脑工程师，  现任阿尔法特公司（Google 母公司）董事长"
"杰夫·贝佐斯，创办了全球最大最成功的电子商务网站之一亚马逊，1999年当选《时代》周刊年度人物。2017年7月17日，《福布斯富豪榜》发布，杰夫·贝佐斯以净资产852亿美元排名第二。"
"马化腾，1971年10月29日生于广东省汕头市潮南区。腾讯公司主要创办人之一，现担任腾讯公司控股董事会主席兼首席执行官；全国青联副主席。"
"马云，1964年9月10日生于浙江省杭州市，阿里巴巴集团主要创始人，现担任阿里巴巴集团董事局主席、日本软银董事、大自然保护协会中国理事会主席兼全球董事会成员、华谊兄弟董事、生命科学突破奖基金会董事。"
"李彦宏，百度公司创始人、董事长兼首席执行官，全面负责百度公司的战略规划和运营管理。"
"王兴，美团网首席执行官，校内网、饭否网、美团网创始人。"
"雷军，1969年12月出生于湖北仙桃，现任小米科技董事长兼首席执行官，同时兼任金山、YY、猎豹移动等三家上市公司董事长，是中国大陆著名天使投资人。"
"杨元庆，现任联想集团董事长兼CEO。柳传志，曾任联想控股有限公司总裁、董事局主席，2011年11月2日卸任。现任联想集团有限公司董事局名誉主席，联想集团高级顾问。"
"任正非，华为技术有限公司主要创始人、总裁"
"刘强东，京东集团首席执行官，1974年2月14日出生于江苏省宿迁市，毕业于中国人民大学。"
)

for (( i=0; i<${#names[@]}; i++ )); do
  echo "${names[$i]}"
  # check whether in databases
  curl -s -o tmp.json -X POST -H "Accept: application/json; charset=UTF-8" -H "Content-Type: application/json" -H "Authorization:'"$autho"'" $neo4j_url -d '{
    "query" : "match (n:`'$label'` {name: {name} }) return n",
    "params" : {
      "name": "'"${names[$i]}"'"
    }
  }'
  grep "metadata" tmp.json > /dev/null
  #count=`wc -l tmp.json | awk '{print $1}'`
  if [ $? -eq 0 ]; then
    echo "already in databases, name: ${names[$i]}"
    continue
  fi
  # import data
  curl -s -o result.json -X POST -H "Accept: application/json; charset=UTF-8" -H "Content-Type: application/json" -H "Authorization:'"$autho"'" $neo4j_url -d '{
    "query" : "create (n:`'$label'` {props} ) return n",
    "params" : {
      "props" : {
        "id": "'"${ids[$i]}"'",
        "name":"'"${names[$i]}"'",
        "PV": "'"${pvs[$i]}"'",
        "老板" : "'"${values[$i]}"'"
      }
    }
  }'
  grep "errors" result.json > /dev/null
  if [ $? -eq 0 ]; then
    echo "fail to create node, name: ${names[$i]}"
  fi
done
rm -f tmp.json result.json
