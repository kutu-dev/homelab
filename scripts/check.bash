#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.." || exit

source ./scripts/modules/_logging.bash

info Checking shell scripts
shellcheck ./**/*.bash

info Checking Nix files
nix fmt flake.nix -- --check

info Checking files with Prettier
prettier . --check