#!/usr/bin/env bash

# Exits the script if a variable is unset or a pipe fails
set -euo pipefail
# Prompts to elevate prividges (so that future sudo calls don't require a password every time)
sudo --validate

# Set current working directory
cd "$(dirname "${BASH_SOURCE[0]}")"

# Source utility functions
source "setup-deps/utils.sh"

runmodule "pc/agetty.sh"
