#!/bin/sh



help()
{
    clear
    echo "------------------------------------------------------------------------------------"
    echo "	                                M A I N - M E N U"
    echo "------------------------------------------------------------------------------------"
    echo "[Argument Info]"
    echo "First Argument: ACTION"
    echo "Second Argument: APPLICATION_NAME"
    echo "Third Argument: DOCKER_CONTAINER_NAME"
    echo
    echo "[Action Info]"
    echo "1 -> show detailed information about a resource"
    echo "2 -> print the logs from a container in a pod"
    echo "3 -> list resources"
    echo "4 -> execute a command on a container in a pod"
    echo "5 -> list docker container name of pod"
    echo
    echo "[Example]"
    echo "1 -> ./kubectl-command.sh [ACTION] [APPLICATION_NAME]"
    echo "2 -> ./kubectl-command.sh [ACTION] [APPLICATION_NAME] [DOCKER_CONTAINER_NAME]"
    echo "3 -> ./kubectl-command.sh [ACTION]"
    echo "4 -> ./kubectl-command.sh [ACTION] [APPLICATION_NAME] [DOCKER_CONTAINER_NAME]"
    echo "5 -> ./kubectl-command.sh [ACTION] [APPLICATION_NAME]"
    echo "------------------------------------------------------------------------------------ \n\n"
}

help

ACTION=$1
APP_NAME=$2
DOCKER_CONTAINER_NAME=$3
POD_NAME=$(kubectl get pods --all-namespaces | awk -v pattern="$APP_NAME" '$0 ~ pattern {print $2}' | head -1)
POD_NAMESPACE=$(kubectl get pods --all-namespaces | awk -v pattern="$APP_NAME" '$0 ~ pattern {print $1}' | head -1)

echo "----------------------------------------------------------"
echo "POD_NAME : $POD_NAME, POD_NAME_SPACE : $POD_NAMESPACE"
echo "----------------------------------------------------------"

case $ACTION in
1)
  kubectl describe pods $POD_NAME --namespace=$POD_NAMESPACE
  ;;
2)
  kubectl logs $POD_NAME --namespace=$POD_NAMESPACE -c $DOCKER_CONTAINER_NAME
  ;;
3)
  kubectl get pods --all-namespaces
  ;;
4)
  kubectl exec -ti $POD_NAME -c $DOCKER_CONTAINER_NAME /bin/bash --namespace=$POD_NAMESPACE
  ;;
5)
  kubectl get pods $POD_NAME -o=custom-columns=NAME:.metadata.name,CONTAINERS:.spec.containers[*].name --namespace=$POD_NAMESPACE
  ;;
*)
  echo "[FAIL] invalid action parameter!!" && exit 1
esac

echo
echo
echo "Done!!"
