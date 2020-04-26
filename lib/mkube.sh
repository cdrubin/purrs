#!/bin/bash

# thanks to https://medium.com/faun/using-minikube-profiles-def2477e968a

# only intercept the profile command.
if [ "$1" == "profile" ]; then
    shift
    
    # current profile
    if [ $# -eq 0 ]; then
        cat ~/.minikube/config/config.json | jq -r .profile
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
        minikube start --profile "$profile_name" "$@"
        minikube profile "$profile_name"
        if [ $? == 0 ]; then
            kubectl config use-context "$profile_name"
        fi
        ;;
        
    delete)
        minikube delete -p "$2"
        rm -rf ~/.minikube/profiles/"$2"
        kubectl config delete-context "$2"
        kubectl config delete-cluster "$2"
        kubectl config unset users."$2"
        ;;
        
    *) # switch profile
        kubectl config use-context "$1"
        if [ $? == 0 ]; then
            minikube profile "$1"
        fi
        ;;
  esac
  exit $?
fi

exec minikube "$@"