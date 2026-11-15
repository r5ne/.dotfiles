#!/bin/sh

# Exits the script if a variable is unset or a pipe fails
set -euo pipefail

echo -e "\033[1;34m::\033[0m Symlinking mimeapps to deprecated ~/.local/share/applications since some apps still use that list."
ln --symbolic --force --no-target-directory --verbose $HOME/.config/mimeapps.list $HOME/.local/share/applications/mimeapps.list
