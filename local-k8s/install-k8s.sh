#!/bin/sh

# Install Operator Lifecycle Manager
curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/v0.27.0/install.sh | bash -s v0.27.0

kubectl create namespace keycloak

./infinispan/install.sh
./keycloak/install.sh