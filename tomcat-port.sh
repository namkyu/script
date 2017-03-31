#!/bin/sh

# --------------------------------------------------------
# tomcat port 추출 방법 설명
# --------------------------------------------------------
#
# sed 's/<!--/\x0<!--/g; s/-->/-->\x0/g'
# <!-- 문자열 앞에 NUL
# --> 문자열 뒤에 NUL 추가한다.
# ASCII Table에 보면 10진수 0은 NUL 16진수 0x00은 NUL로 되어 있다.
#
# grep -zv '^<!--'
# 첫 시작 문자가 <!-- 아니면 문자열 NUL 처리
#
# tr -d '\0'
# NUL 문자 포함되어 있는 라인 삭제
#
# grep -o 'port="[0-9]*'
# port="숫자" 포함되어 있는 라인
#
# sed "s/.*port=\"\([0-9]*\)\".*/\1/"
# port="숫자" 숫자 값 출력


if [ -z $1 ]; then
  echo "[FAIL] you need to write path!!"
  exit 1
fi

SERVER_XML_LIST=$(find $1 -name 'server.xml' -not -path '*/.pc/*' -not -path '*/._DEFAULT_/*')


echo "+--------------+--------------+------+-------+"
echo "| Tomcat       | Shutdown     | HTTP | AJP13 |"
echo "+--------------+--------------+------+-------+"

for serverXml in $SERVER_XML_LIST; do
    PORT_LIST=$(cat $serverXml | sed 's/<!--/\x0<!--/g; s/-->/-->\x0/g' | grep -zv '^<!--' | tr -d '\0' | grep 'port=\"[0-9]*' | sed 's/.*port=\"\([0-9]*\)\".*/\1/')
    port=$(echo $PORT_LIST | tr '\n' ' ')
    printf "%-80s\t%s\n" "$serverXml" "$port"
done
echo "+--------------+--------------+------+-------+"
