#!/usr/bin/env bash
set -e # exit if any command fails

# Dependencies to run the script
REQUIRED_PKGS=("ntp", "dash", "tlp")

# Exit if dependencies are unmet
if ! MISSING_PKGS=$(pacman --deptest "${REQUIRED_PKGS[@]}"); then
    echo "Error: Missing required package dependencies: " >&2
    echo "$MISSING_PKGS" | sed 's/^/  - /'
    exit 1
fi
echo "All dependencies satisfied, commencing setups..."

# NTP setup
echo "Setting up sntp service and timer."
SYSTEM_SERVICE_DIR="/etc/systemd/system"
sudo cp --verbose ./setup-deps/sntp/sntp.service $SYSTEM_SERVICE_DIR
sudo cp --verbose ./setup-deps/sntp/sntp.timer $SYSTEM_SERVICE_DIR
sudo systemctl enable --now --verbose "$SYSTEM_SERVICE_DIR/sntp.timer"

# Symlink dash to /bin/sh
echo "Replacing bash with dash."
sudo ln --symbolic --force --no-target-directory --verbose dash /usr/bin/sh

# Dash post install setup
# Make a pacman hook so that bash updates don't overwrite the /usr/bin/sh symlink
echo "Setting up a pacman hook so bash updates don't overwrite dash."
PACMAN_HOOK_DIR="/etc/pacman.d/hooks"
mkdir --parents "$PACMAN_HOOK_DIR"
sudo cp --verbose ./setup-deps/dash/dash.hook $PACMAN_HOOK_DIR

# Set up username autofill service for tty1 using agetty
echo "Setting up a username autofill agetty service"
AGETTY_SERVICE_DIR="/etc/systemd/system/getty@tty1.service.d"
mkdir --parents "$AGETTY_SERVICE_DIR"
sudo cp --verbose ./setup-deps/agetty/override.conf $AGETTY_SERVICE_DIR

echo "Setting up tlp overrides."
TLP_OVERRIDES_DIR="/etc/tlp.d"
sudo cp --verbose ./setup-deps/tlp/00-enable-wifi-at-startup.conf $TLP_OVERRIDES_DIR
sudo cp --verbose ./setup-deps/tlp/01-battery-charge-threshold.conf $TLP_OVERRIDES_DIR
