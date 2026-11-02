#!/usr/bin/env bash

# Exits the script if a variable is unset or a pipe fails
set -euo pipefail
# Prompts to elevate prividges (so that future sudo calls don't require a password every time)
sudo --validate

# Set current working directory
cd "$(dirname "${BASH_SOURCE[0]}")"

# Source utility functions
source "setup-deps/utils.sh"

msg "Adding autologin to tty1."
sudoinstall "./setup-deps/laptop/autologin.conf" "/etc/systemd/system/getty@tty1.service.d/override.conf"

msg "Adding tlp overrides."
sudoinstall ./setup-deps/laptop/00-enable-wifi-at-startup.conf /etc/tlp.d/00-enable-wifi-at-startup.conf
sudoinstall ./setup-deps/laptop/01-battery-charge-threshold.conf /etc/tlp.d/01-battery-charge-threshold.conf
