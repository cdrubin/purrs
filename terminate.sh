#! /bin/bash

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)
pushd $SCRIPT_DIR > /dev/null

echo "purrs minikube profile being deleted..."
lib/mkube.sh profile delete purrs

popd > /dev/null
