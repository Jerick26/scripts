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

key="创始人"

values=(
"史蒂夫·乔布斯,1955年2月24日生于美国加利福尼亚州旧金山,美国发明家、企业家、美国苹果公司联合创办人。"
"谷歌有两位创始人，谢尔盖布林出生于莫斯科，是马里兰大学的荣誉毕业生，拥有数学和计算机专业的理学学士学位。随后他考入斯坦福大学计算机专业就读。他从计算机研究所博士班休学，全力发展谷歌公司。拉里佩奇毕业于密歇根州安娜堡大学，拥有理学学士学位。受担任计算机系教授的父亲启蒙，佩奇早在1979年就开始使用计算机了。他就暂时从斯坦福大学计算机研究所博士班休学与好友布林共同经营谷歌公司。"
)

set -x

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
  if [ $? -ne 0 ]; then
    echo "node not existed, name: ${names[$i]}"
    continue
  fi
  # update nodes
  curl -s -o result.json -X POST -H "Accept: application/json; charset=UTF-8" -H "Content-Type: application/json" -H "Authorization:'"$autho"'" $neo4j_url -d '{
    "query" : "match (n:`'$label'` { name: {name}, id: {id} } ) set n.'$key' = {value} return n",
    "params" : {
      "name": "'"${names[$i]}"'",
      "id" : "'"${ids[$i]}"'",
      "value" : "'"${values[$i]}"'"
    }
  }'
  grep "metadata" result.json > /dev/null
  if [ $? -eq 0 ]; then
    echo "success to update node, name: ${names[$i]}"
  fi
done
