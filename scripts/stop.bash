#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.." || exit

source ./scripts/modules/_logging.bash

STACK_NAME=$1

if [ "$STACK_NAME" == "" ]; then
    error "Please provide the name of the stack to start"
    exit 1
fi

sudo docker stack rm "$STACK_NAME"