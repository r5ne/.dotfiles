#!/usr/bin/env bash

msg() { echo -e "\033[1;34m::\033[0m $1"; }
err() { echo -e "\033[1;31m!!\033[0m $1" >&2; exit 1; }
sudoinstall() { sudo install -D --debug --mode=664 --owner=root --group=root --compare "$@"; }

runmodule() {
    local script_path="setup-deps/scripts/$1"
    if [[ -f "$script_path" ]]; then
	msg "Executing script: $1"
	source "$script_path"
    else
	err "Script not found: $script_path"
    fi
}
