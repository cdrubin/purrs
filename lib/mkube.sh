#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)
PARENT_DIR=$(dirname ${SCRIPT_DIR})

# thanks to https://medium.com/faun/using-minikube-profiles-def2477e968a

# only intercept the profile command.
if [ "$1" == "profile" ]; then
    shift
    
    # current profile
    if [ $# -eq 0 ]; then
        cat ~/.minikube/config/config.json | "${PARENT_DIR}/bin/jq" -r .profile
        exit $?
    fi
    
    case "$1" in
    
    list)
        ls -1 ~/.minikube/profiles/
        ;;
        
    describe)
        cat ~/.minikube/profiles/"$2"/config.json
        ;;
        
    create)
        shift
        profile_name="$1"
        shift
        "${PARENT_DIR}/bin/minikube" start --profile "$profile_name" "$@"
        "${PARENT_DIR}/bin/minikube" profile "$profile_name"
        if [ $? == 0 ]; then
            "${PARENT_DIR}/bin/kubectl" config use-context "$profile_name"
        fi
        ;;
        
    delete)
        "${PARENT_DIR}/bin/minikube" delete -p "$2"
        rm -rf ~/.minikube/profiles/"$2"
        "${PARENT_DIR}/bin/kubectl" config delete-context "$2"
        "${PARENT_DIR}/bin/kubectl" config delete-cluster "$2"
        "${PARENT_DIR}/bin/kubectl" config unset users."$2"
        ;;
        
    *) # switch profile
        "${PARENT_DIR}/bin/kubectl" config use-context "$1"
        if [ $? == 0 ]; then
            "${PARENT_DIR}/bin/minikube" profile "$1"
        fi
        ;;
  esac
  exit $?
fi

exec "${PARENT_DIR}/bin/minikube" "$@"