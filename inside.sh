#! /bin/bash

SCRIPT_DIR=$(readlink -f $(dirname $0))
pushd $SCRIPT_DIR > /dev/null

source lib/bash_ui.sh

CHOICES=`kubectl get pods | tail -n +2 | awk '{print $1}'`

choose_one
POD=$CHOSEN

CHOICES=`kubectl get pods $POD -o jsonpath='{.spec.containers[*].name}' | tr " " "\n"`

# count number of spaces (choices - 1)
NUMBER_OF_SPACES=`echo $CHOICES | tr -cd ' ' | wc -c`

if [ $NUMBER_OF_SPACES -gt 0 ]; then
    choose_one
    CONTAINER=$CHOSEN
else
	CONTAINER=`echo $CHOICES | xargs`
fi

echo
kubectl exec -it $POD --container $CONTAINER -- /bin/ash

popd > /dev/null