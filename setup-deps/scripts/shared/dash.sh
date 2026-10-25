#!/usr/bin/env bash

# Symlink dash to /bin/sh
msg "Replacing bash with dash..."
sudo ln --symbolic --force --no-target-directory --verbose dash /usr/bin/sh

# Dash post install setup
# Make a pacman hook so that bash updates don't overwrite the /usr/bin/sh symlink
msg "Setting up a pacman hook so bash updates don't overwrite dash."
sudoinstall ./setup-deps/shared/dash.hook /etc/pacman.d/hooks/dash.hook
