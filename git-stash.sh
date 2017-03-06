#!/bin/sh

##################################
## 도움말
##################################
help()
{
  echo "====================================================="
  echo "Usage:
    저장 -> ./git-stash.sh [ACTION] [TITLE]
    복원 -> ./git-stash.sh [ACTION]"
  echo "Example:
    저장 -> ./git-stash.sh save saveWorkingJob
    복원 -> ./git-stash.sh pop"
  echo "====================================================="
}

help

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
STASH_LIST=$(git stash list)
action=$1


##################################
## 유효성 검사
##################################
if [ $CURRENT_BRANCH = 'develop' -o $CURRENT_BRANCH = 'master' ]; then
  echo "==> [FAIL] don't use this program in the ${CURRENT_BRANCH} branche"
  exit 1
fi

if [ -z $action ]; then
  echo "[FAIL] you need to write action parameter!!"
  exit 1
fi

if [ $action = 'save' ]; then
  if [ -z $2 ]; then
    echo "[FAIL] please enter save title!!" && exit 1
  fi

  if [ ${#STASH_LIST} -ne 0 ]; then
    echo "[FAIL] stored stashes already!!" && exit 1
  fi
fi

##################################
## 실행
##################################
case $action in
save)
  git stash save -u "$2"
  ;;
pop)
  git stash pop
  ;;
*)
  echo "[FAIL] invalid action parameter!!" && exit 1
esac

echo "Done!!"