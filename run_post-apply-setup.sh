#!/bin/sh

# Exits the script if a variable is unset or a pipe fails
set -euo pipefail

echo "\033[1;34m::\033[0m Symlinking mimeapps to deprecated ~/.local/share/applications since some apps still use that list."
ln --symbolic --force --no-target-directory --verbose $HOME/.config/mimeapps.list $HOME/.local/share/applications/mimeapps.list

echo "\033[1;34m::\033[0m Updating mise to install tools defined in ~/.config/mise/config.toml"
mise install

echo "\033[1;34m::\033[0m Installing coursier tools"
cs install metals
