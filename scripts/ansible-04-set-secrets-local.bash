#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.." || exit

cd ansible

ansible-playbook 04-set-secrets.yml -K -i inventory-local.ini -e @secrets.enc.yaml --ask-vault-pass