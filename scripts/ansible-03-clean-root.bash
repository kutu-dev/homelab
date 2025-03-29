#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.." || exit

cd ansible

ansible-playbook 03-clean-root.yml -K -i inventory-remote.ini