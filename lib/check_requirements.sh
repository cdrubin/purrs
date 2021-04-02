#! /bin/bash

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)
PARENT_DIR=$(dirname ${SCRIPT_DIR})
pushd $SCRIPT_DIR > /dev/null


# get full path of running script and grep for 'exit_show_progress' calls
# count the number of exits in this script to track checks and increments
# TOTAL_PASSED after getting past each one.
TOTAL_REQUIREMENTS=$(grep '((TOTAL_PASSED+=1))' ${PARENT_DIR}/lib/check_requirements.sh | wc -l | tr -d [:space:] )
TOTAL_PASSED=1


# show progress
function sp {
    echo -e $(mu)"(${TOTAL_PASSED} of ${TOTAL_REQUIREMENTS} requirements satisfied)"$(m0)
}

# mode underline
function mu {
    echo -e "\033[4m"
}

# mode bold
function mb {
    echo -e "\033[1m"
}

# mode inverse
function mi {
    echo -e "\033[7m"
}

# mode restore
function m0 {
    echo -e "\033[0m"
}

# echo random emoji
function em {
    emojis="👾🤖💗💥👣🐶🐩🐺🦊🐈🐴🐮🐃🐷🐗🐫🐘🐁🐇🐿🐨🐔🐓🐦🐧🦅🦆🐢🦎🐳🐬🐡🐙🐚🐠🐌🦋🐛🐜🐝🐞🦂🏵🌺🌼🌱🌵🍁🍃🍈🍌🍊🍑🍐🥑🥔🥒🥐🥞🧀🥗🍡🍧🍪🍫🍵🥃🔪⛰🏕🏞🏟🏗🏭🚂🚆🚈🚎🚒🚕🚜🛵🛤🛶🛩🚡🛰"
    echo "${emojis:$(( RANDOM % ${#emojis} )):1}"
}

# if no skaffold then install
if [ ! -x "$PARENT_DIR/bin/skaffold" ]; then
    echo "installing skaffold...   $(sp)"
    if [ "$(uname)" == "Darwin" ]; then
        curl -Lo "$PARENT_DIR/bin/skaffold" -C - https://storage.googleapis.com/skaffold/releases/latest/skaffold-darwin-amd64 && chmod +x "$PARENT_DIR/bin/skaffold"
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        curl -Lo "$PARENT_DIR/bin/skaffold" -C - https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && chmod +x  "$PARENT_DIR/bin/skaffold"
    fi
fi
((TOTAL_PASSED+=1))


# if no minikube then install
if [ ! -x "$PARENT_DIR/bin/minikube" ]; then
    echo "installing minikube...   $(sp)"
    if [ "$(uname)" == "Darwin" ]; then
        curl -Lo "$PARENT_DIR/bin/minikube" -C - https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 && chmod +x "$PARENT_DIR/bin/minikube"
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        curl -Lo "$PARENT_DIR/bin/minikube" -C - https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x "$PARENT_DIR/bin/minikube"
    fi
fi
((TOTAL_PASSED+=1))


# if no minikube then install
if [ ! -x "$PARENT_DIR/bin/kubectl" ]; then
    echo "installing kubectl...   $(sp)"
    if [ "$(uname)" == "Darwin" ]; then
        curl -Lo "$PARENT_DIR/bin/kubectl" -C - https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/darwin/amd64/kubectl && chmod +x "$PARENT_DIR/bin/kubectl"
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        curl -Lo "$PARENT_DIR/bin/kubectl" -C - https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && chmod +x "$PARENT_DIR/bin/kubectl"
    fi
fi
((TOTAL_PASSED+=1))


# if no kustomize then install
if [ ! -x "$PARENT_DIR/bin/kustomize" ]; then
    echo "installing kustomize...   $(sp)"
    curl -s https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh | bash && chmod +x kustomize && mv kustomize "$PARENT_DIR/bin/kustomize"
fi
((TOTAL_PASSED+=1))


# if no jq then offer install instructions
if [ ! -x "$PARENT_DIR/bin/jq" ]; then
    echo "installing jq...   $(sp)"
    if [ "$(uname)" == "Darwin" ]; then
        curl -Lo "$PARENT_DIR/bin/jq" -C - https://github.com/stedolan/jq/releases/download/jq-1.6/jq-osx-amd64 && chmod +x "$PARENT_DIR/bin/jq"
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        curl -Lo "$PARENT_DIR/bin/jq" -C - https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && chmod +x "$PARENT_DIR/bin/jq"
    fi
fi
((TOTAL_PASSED+=1))


popd > /dev/null