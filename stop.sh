#! /bin/bash

SCRIPT_DIR=$(readlink -f $(dirname $0))
pushd $SCRIPT_DIR > /dev/null

echo "purrs minikube profile being deleted..."
./lib/mkube.sh profile delete purrs

popd > /dev/null