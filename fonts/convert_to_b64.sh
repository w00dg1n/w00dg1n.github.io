#/usr/bin/sh

#ires=$(cat $1 | base64)
#echo $res

while read line
do
  font_file=$(echo $line | gawk '{match($0, /src:url\(\S*\/fonts\/(\S+)\) format\("woff2/, mres); print mres[1];}')
  font_b64=$(cat $font_file | base64)
  new_url=$(echo "src:url(data:font\/woff2;charset=utf-8;base64,$font_b64) format(\"woff2\")")
  result=$(echo $line | sed -e "s/src:.* format(\"woff2\")/<placeholder>/g")
  # echo "${line//src:url\S+\sformat(\"woff2\")/test}"
  echo "${result//<placeholder>/$new_url}"
done < "${1:-/dev/stdin}"