#! /bin/bash

SCRIPT_DIR=$(readlink -f $(dirname $0))
pushd $SCRIPT_DIR > /dev/null

source lib/bash_ui.sh

MEMORY=4096
CPUS=2

# save the current minikube profile to pop back after status call
MINIKUBE_PROFILE=$(./lib/mkube.sh profile > /dev/null)

# if there is no current profile selected then switch to purrs
if [ "$MINIKUBE_PROFILE" = "" ]; then
    MINIKUBE_PROFILE="minikube"
fi

# check that minikube profile purrs exists
if ! ./lib/mkube.sh profile list | grep purrs > /dev/null; then
    echo "purrs minikube profile not found, creating..."
    ./lib/mkube.sh profile delete purrs && ./lib/mkube.sh profile create purrs --memory=$MEMORY --cpus=$CPUS
    
else
    # check purrs status and restore profile after
    ./lib/mkube.sh profile purrs &> /dev/null
    RUNNING=$(minikube status 2> /dev/null | grep 'Running' | wc -l)
    CONFIGURED=$(minikube status 2> /dev/null | grep 'Configured' | wc -l)
    ./lib/mkube.sh profile $MINIKUBE_PROFILE &> /dev/null
    
    if [[ $RUNNING -ne 3 || $CONFIGURED -ne 1 ]]; then
        echo "purrs minikube profile errors, recreating..."
        ./lib/mkube.sh profile delete purrs
        ./lib/mkube.sh profile create purrs --memory=$MEMORY --cpus=$CPUS
    fi
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

skaffold dev --port-forward --profile deployment --minikube-profile purrs

popd > /dev/null