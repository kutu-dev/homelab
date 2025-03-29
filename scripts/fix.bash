#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.." || exit

source ./scripts/modules/_logging.bash

info Setting script permissions
chmod u+x ./**/*.bash

info Formatting Nix files
nix fmt flake.nix 

info Fixing files with Prettier
prettier . --write