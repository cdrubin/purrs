#! /bin/bash

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)
pushd $SCRIPT_DIR > /dev/null

echo "purrs minikube profile being stopped..."
bin/minikube stop

popd > /dev/null