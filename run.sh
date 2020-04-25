#! /bin/bash

SCRIPT_DIR=$(readlink -f $(dirname $0))
pushd $SCRIPT_DIR > /dev/null

source lib/bash_ui.sh

MEMORY=4096
CPUS=2

# if no minikube environent try to delete and create one
if [ $(minikube status | grep 'Running' | wc -l) -ne 3 ]; then
    echo "purrs minikube environment not running, recreating..."
    minikube delete && minikube start --memory=$MEMORY --cpus=$CPUS
fi


# if source code not initialized then initialize

# 

read -r -d '' CHOICES <<EOLIST
development
staging
production
EOLIST

choose_one
APP_ENV=$CHOSEN

# substitute the TARGET name into kustomize directory name
sed -i "s#overlays.*#overlays/${APP_ENV}#" skaffold.yaml

skaffold dev --port-forward --profile deployment

popd > /dev/null