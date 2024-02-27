#!/bin/sh

echo "installing infinispan operator"
kubectl create -f https://operatorhub.io/install/infinispan.yaml

LAST_STATUS=1
while (( $LAST_STATUS ))
do
  kubectl --namespace operators rollout status deployment infinispan-operator-controller-manager
  LAST_STATUS=$?
  sleep 5
done

echo "deploying infinispan"
cd infinispan
kubectl --namespace=keycloak apply -f infinispan.yaml --wait
sleep 5
kubectl --namespace=keycloak rollout status deployment infinispan-router
sleep 3
kubectl --namespace=keycloak rollout status statefulset infinispan
sleep 3
kubectl --namespace=keycloak rollout status deployment infinispan-config-listener
cd ..