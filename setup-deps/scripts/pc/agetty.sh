#!/usr/bin/env bash

msg "Adding autologin to tty1."
sudoinstall "./setup-deps/pc/autologin.conf" "/etc/systemd/system/getty@tty1.service.d/override.conf"
