#!/usr/bin/env bash

# Exits the script if a variable is unset or a pipe fails
set -euo pipefail
# Requires the script to be run with sudo
sudo --validate

# Set current working directory
cd "$(dirname "${BASH_SOURCE[0]}")"

# Source utility functions
source "setup-deps/utils.sh"

runmodule "shared/dash.sh"
runmodule "shared/zsh.sh"
