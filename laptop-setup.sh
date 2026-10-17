#!/usr/bin/env bash
set -e # exit if any command fails

# Dependencies to run the script
REQUIRED_PKGS=("ntp", "dash")

# Exit if dependencies are unmet
if ! MISSING_PKGS=$(pacman --deptest "${REQUIRED_PKGS[@]}"); then
    echo "Error: Missing required package dependencies: " >&2
    echo "$MISSING_PKGS" | sed 's/^/  - /'
    exit 1
fi
echo "All dependencies satisfied, commencing setups..."

# NTP setup
SERVICE_DIR="/etc/systemd/system"
sudo cp --verbose ./setup-deps/sntp.service $SERVICE_DIR
sudo cp --verbose ./setup-deps/sntp.timer $SERVICE_DIR
sudo systemctl enable --now --verbose "$SERVICE_DIR/sntp.timer"

# Symlink dash to /bin/sh
sudo ln --symbolic --force --no-target-directory --verbose dash /usr/bin/sh

# Dash post install setup
# Make a pacman hook so that bash updates don't overwrite the /usr/bin/sh symlink
HOOK_DIR="/etc/pacman.d/hooks"
mkdir --parents "$HOOK_DIR"
sudo cp --verbose ./setup-deps/dash.hook $HOOK_DIR
