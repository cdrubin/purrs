#! /bin/bash

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)
pushd $SCRIPT_DIR > /dev/null


MEMORY=4096
CPUS=2


# mode inverse
function mi {
    echo -e "\033[7m"
}

# mode restore
function m0 {
    echo -e "\033[0m"
}


# check that skaffold  is not running already
if ps -ef | grep "[s]kaffold dev" &> /dev/null; then
    echo "🚏 $(mi) Competition $(m0) skaffold already seems to be running, right?"
    exit
fi


# check requirement and exit this script too if failure
if ! lib/check_requirements.sh; then
    exit
fi


# save the current minikube profile to pop back after status call
MINIKUBE_PROFILE=$(lib/mkube.sh profile > /dev/null)


# if there is no current profile selected then switch to minikube
if [ "$MINIKUBE_PROFILE" = "" ]; then
    MINIKUBE_PROFILE="minikube"
fi


# check that the profile exists
if ! lib/mkube.sh profile list | grep purrs > /dev/null; then
    echo "purrs minikube profile not found, creating..."
    lib/mkube.sh profile delete purrs &> /dev/null
    lib/mkube.sh profile create purrs --memory=$MEMORY --cpus=$CPUS
    
else
    # check status and restore if possible
    lib/mkube.sh profile purrs &> /dev/null
    STOPPED=$(bin/minikube status 2> /dev/null | grep 'Stopped' | wc -l)
    
    # if all are stopped try to restart
    if [[ $STOPPED -eq 4 ]]; then
        echo "purrs minikube profile is stopped, restarting..."
        bin/minikube start
    fi
    
    RUNNING=$(bin/minikube status 2> /dev/null | grep 'Running' | wc -l)
    CONFIGURED=$(bin/minikube status 2> /dev/null | grep 'Configured' | wc -l)
    
    # now check minikube ready
    if [[ $RUNNING -ne 3 || $CONFIGURED -ne 1 ]]; then
        echo "acluptec minikube profile errors, recreating..."
        lib/mkube.sh profile delete purrs
        lib/mkube.sh profile create purrs --memory=$MEMORY --cpus=$CPUS
    fi
fi

lib/mkube.sh profile $MINIKUBE_PROFILE &> /dev/null

echo
echo "Choose the application to skaffold: "

CHOICES=`find deployment -maxdepth 1 -mindepth 1 -name "[a-z\-]*" -type d | xargs -n1 basename | sort`
SKAFFOLD=$(echo "$CHOICES" | ./lib/shui 2>&1 1>/dev/tty)


OLDPATH="$PATH"
PATH="$SCRIPT_DIR/bin:$OLDPATH"
pushd deployment/$SKAFFOLD > /dev/null
$SCRIPT_DIR/bin/skaffold config set --global collect-metrics false > /dev/null
$SCRIPT_DIR/bin/skaffold dev --port-forward --minikube-profile purrs --profile deployment
PATH="$OLDPATH"
popd > /dev/null

popd > /dev/null