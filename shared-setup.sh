#!/usr/bin/env bash

# Exits the script if a variable is unset or a pipe fails
set -euo pipefail
# Requires the script to be run with sudo
sudo --validate

# Set current working directory
cd "$(dirname "${BASH_SOURCE[0]}")"

# Source utility functions
source "setup-deps/utils.sh"

# Symlink dash to /bin/sh
msg "Replacing bash with dash..."
sudo ln --symbolic --force --no-target-directory --verbose dash /usr/bin/sh

# Dash post install setup
# Make a pacman hook so that bash updates don't overwrite the /usr/bin/sh symlink
msg "Setting up a pacman hook so bash updates don't overwrite dash."
sudoinstall ./setup-deps/shared/dash.hook /etc/pacman.d/hooks/dash.hook

msg "Setting zsh ZDOTDIR to ~/.config/zsh"
sudoinstall ./setup-deps/shared/zshenv /etc/zsh/zshenv

mkdir --parents --verbose "$HOME/.config/zsh"
    if [ ! -d "$HOME/.config/zsh/pure" ]; then
    git clone https://github.com/sindresorhus/pure.git "$HOME/.config/zsh/pure"
else
    msg "Pure prompt already installed, pulling latest instead."
    git -C "$HOME/.config/zsh/pure" pull
fi

# NTP setup
msg "Setting up sntp service via a timer."
sudoinstall ./setup-deps/shared/sntp.service /etc/systemd/system/sntp.service
sudoinstall ./setup-deps/sntp/sntp.timer /etc/systemd/system/sntp.timer
sudo systemctl enable --now --verbose "/etc/systemd/system/sntp.timer"

# DNS setup
msg "Overriding the default ISP DNS with Cloudflare."
sudoinstall ./setup-deps/shared/resolved.conf /etc/systemd/resolved.conf
