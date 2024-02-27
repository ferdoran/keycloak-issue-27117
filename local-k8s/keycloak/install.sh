#!/bin/sh

cd keycloak

# deploy postgres
echo "deploying postgres database"
kubectl apply -f ./postgres.yaml
kubectl --namespace=keycloak rollout status statefulset postgresql-db

# deploy keycloak
echo "building custom keycloak image"
docker build -t custom-keycloak:22 .

#kubectl apply -f tls-secret.yaml --wait
echo "removing previous keycloak"
kubectl delete -f keycloak-yaml --wait
echo "deploying keycloak"
kubectl apply -f keycloak.yaml --wait
sleep 5
kubectl --namespace=keycloak rollout status statefulset keycloak
cd ..