#! /bin/bash

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)
pushd $SCRIPT_DIR > /dev/null


CHOICES=`bin/kubectl get pods | tail -n +2 | awk '{print $1}'`

POD=$(echo "$CHOICES" | ./lib/shui 2>&1 1>/dev/tty)

CHOICES=`bin/kubectl get pods $POD -o jsonpath='{.spec.containers[*].name}' | tr " " "\n"`

# count number of spaces (choices - 1)
NUMBER_OF_SPACES=`echo $CHOICES | tr -cd ' ' | wc -c`

if [ $NUMBER_OF_SPACES -gt 0 ]; then
    CONTAINER=$(echo "$CHOICES" | ./lib/shui 2>&1 1>/dev/tty)
else
	CONTAINER=`echo $CHOICES | xargs`
fi

echo
bin/kubectl exec -it $POD --container $CONTAINER -- /bin/bash

popd > /dev/null