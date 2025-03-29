#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.." || exit

source ./scripts/modules/_logging.bash

USER_PASSWORD="$1"

if [ "$USER_PASSWORD" == "" ]; then
    error Missing the name of the main user 'homelab', please provide it as the first argument
    exit 1
fi

cd ansible

ansible-playbook 01-root-setup.yml --extra-vars "user_password=$USER_PASSWORD" -i inventory-remote.ini