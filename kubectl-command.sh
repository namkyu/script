#!/bin/sh



help()
{
    clear
    echo "------------------------------------------------------------------------------------"
    echo "	                                M A I N - M E N U"
    echo "------------------------------------------------------------------------------------"
    echo "[Argument Info]"
    echo "First Argument: action"
    echo "Second Argument: application name"
    echo "Third Argument: docker container name"
    echo
    echo "[Action Info]"
    echo "1 -> show detailed information about a resource"
    echo "2 -> print the logs from a container in a pod"
    echo "3 -> list resources"
    echo "4 -> execute a command on a container in a pod"
    echo "5 -> list docker container name of pod"
    echo
    echo "[Example]"
    echo "1 -> ./kubectl-command.sh 1 bootcamp"
    echo "2 -> ./kubectl-command.sh 2 bootcamp"
    echo "3 -> ./kubectl-command.sh 3"
    echo "4 -> ./kubectl-command.sh 4 bootcamp kubernetes-bootcamp"
    echo "5 -> ./kubectl-command.sh 5 bootcamp"
    echo "------------------------------------------------------------------------------------ \n\n"
}

help

ACTION=$1
APP_NAME=$2
DOCKER_CONTAINER_NAME=$3
POD_NAME=$(kubectl get pods | awk -v pattern="$APP_NAME" '$0 ~ pattern {print $1}' | head -1)

case $ACTION in
1)
  kubectl describe pods $POD_NAME
  ;;
2)
  kubectl logs $POD_NAME
  ;;
3)
  kubectl get pods
  ;;
4)
  kubectl exec -ti $POD_NAME -c $DOCKER_CONTAINER_NAME /bin/bash
  ;;
5)
  kubectl get pods $POD_NAME -o=custom-columns=NAME:.metadata.name,CONTAINERS:.spec.containers[*].name
  ;;
*)
  echo "[FAIL] invalid action parameter!!" && exit 1
esac

echo
echo
echo "Done!!"
