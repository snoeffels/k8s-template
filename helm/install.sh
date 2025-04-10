#!/usr/bin/env bash

set +x
set -e

echo "DEPLOYMENT_NAMESPACE=${DEPLOYMENT_NAMESPACE:=co2-calculator-coppa}"
echo "DEPLOYMENT_HOST=${DEPLOYMENT_HOST:=co2-calculator-coppa.prod-k8s.eecc.de}"
echo "DEPLOYMENT_TAG=${DEPLOYMENT_TAG:=dev}"

helm upgrade --kube-context eecc-prod --create-namespace --namespace $DEPLOYMENT_NAMESPACE \
    --set host="$DEPLOYMENT_HOST" \
    --set app.tag="$DEPLOYMENT_TAG" \
    --install co2-calculator-coppa ./

echo
echo "[DONE] co2-calculator-coppa"
echo


