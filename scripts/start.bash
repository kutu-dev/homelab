#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.." || exit

source ./scripts/modules/_logging.bash

STACK_NAME=$1

if [ "$STACK_NAME" == "" ]; then
    error "Please provide the name of the stack to start"
    exit 1
fi

cd "services/$STACK_NAME" || exit

export $(cat .env) > /dev/null 2>&1
sudo -E DOCKER_USER_UID=1000 DOCKER_USER_GID=1000 docker stack deploy --compose-file compose.yaml "$STACK_NAME" --detach