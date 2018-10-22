#!/bin/sh

echo "================================="
echo "Auto Pull Started!!"
echo "================================="

check_command()
{
  $1
  if [ $? -ne 0 ]; then
    echo "================================="
    echo "FAILED Auto Pull!!"
    echo "================================="
    exit 1
  fi
}

check_command "git checkout develop"
check_command "git pull origin develop"
check_command "git checkout master"
check_command "git pull origin master"

echo "================================="
echo "Done!!"
echo "================================="