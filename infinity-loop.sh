#!/bin/sh

if [ -z $1 ]; then
  echo "[FAIL] you need to write process name!!"
  exit 1
fi

while [ : ];
do
    ps -ef | grep $1 | grep -v grep | grep -v '/bin/sh';
    sleep 1;
done