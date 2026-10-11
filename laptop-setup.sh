#!/usr/bin/env bash
set -e # exit if any command fails

# Dependencies:
# dash, sntp

# NTP setup
SERVICE_DIR="/etc/systemd/system"
sudo cp -v ./setup-deps/sntp.service $SERVICE_DIR
sudo cp -v ./setup-deps/sntp.timer $SERVICE_DIR
sudo systemctl enable --now "$SERVICE_DIR/sntp.timer"

# Dash post install setup
# Make a pacman hook so that bash updates don't overwrite the /usr/bin/sh symlink
HOOK_DIR="/etc/pacman.d/hooks"
mkdir -p "$HOOK_DIR"
sudo cp -v ./setup-deps/dash.hook $HOOK_DIR
