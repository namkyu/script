#!/bin/sh
# Automatically merge the last commit through the following branches:

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
LAST_COMMIT=$(git rev-list -1 HEAD)

echo "================================="
echo "Merge Started!!"
echo "================================="
echo "Automatically merging commit $LAST_COMMIT from $CURRENT_BRANCH rippling to develop"

check_command()
{
  $1
  if [ $? -ne 0 ]; then
    echo "================================="
    echo "MERGE FAILED!!"
    echo "================================="
    exit 1
  fi
}

if [ $CURRENT_BRANCH = 'develop' -o $CURRENT_BRANCH = 'master' ]; then
  echo "==> don't process to merge in the ${CURRENT_BRANCH} branche"
  exit 1
fi

case $CURRENT_BRANCH in
feature/*)
  check_command "git checkout develop"
  check_command "git pull origin develop"
  check_command "git merge $CURRENT_BRANCH"
  check_command "git push origin develop"
  check_command "git checkout $CURRENT_BRANCH"
  ;;
hotfix/*)
  check_command "git checkout develop"
  check_command "git pull origin develop"
  check_command "git merge $CURRENT_BRANCH"
  check_command "git push origin develop"
  check_command "git checkout master"
  check_command "git pull origin master"
  check_command "git merge $CURRENT_BRANCH"
  check_command "git push origin master"
  check_command "git checkout $CURRENT_BRANCH"
  ;;
esac

if [ $? -ne 0 ]; then
  echo "================================="
  echo "MERGE FAILED!!"
  echo "================================="
  exit 1
fi

echo "================================="
echo "Done!!"
echo "================================="