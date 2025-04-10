#!/usr/bin/env bash

set +x
set -e


NAME=$(grep name Chart.yaml | grep --only-matching "\s.*" | grep --only-matching "\S*")

NAMESPACE=${DEPLOYMENT_NAMESPACE:=$1}


if [ -z "${NAMESPACE}" ]; then
  echo "Namespace is not set or is empty"
  exit 1
fi


echo "Are you sure you want to permanently delete namespace ${NAMESPACE}? All data will be erased!"


# Prompt the user for confirmation free to go for env execution
if [ "$1" == "$NAMESPACE" ]; then
  read -r -p "Do you really want to uninstall $NAME namespace $NAMESPACE? (y/N): " answer
  case $answer in
  [Yy]*) ;;
  *) exit 0 ;;
  esac
  read -p "(Enter '${NAMESPACE}' to confirm): " user_input

  # Check if the input matches the environment variable
  if [ "$user_input" == "${NAMESPACE}" ]; then
      echo "Proceeding to delete namespace ${NAMESPACE}"
  else
      echo "Action cancelled. Exiting."
      exit 1
  fi
fi


helm uninstall --kube-context eecc-prod --ignore-not-found --namespace $NAMESPACE co2-calculator-coppa

echo
echo "[DONE] co2-calculator-coppa"
echo


kubectl --context eecc-prod delete namespace $NAMESPACE