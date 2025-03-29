#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.." || exit

cd ansible

ansible-playbook 02-user-setup.yml -K -i inventory-remote.ini