#!/usr/bin/env bash

msg "Setting zsh ZDOTDIR to ~/.config/zsh"
sudoinstall ./setup-deps/shared/zshenv /etc/zsh/zshenv

mkdir --parents --verbose "$HOME/.config/zsh"
    if [ ! -d "$HOME/.config/zsh/pure" ]; then
    git clone https://github.com/sindresorhus/pure.git "$HOME/.config/zsh/pure"
else
    msg "Pure prompt already installed, pulling latest instead."
    git -C "$HOME/.config/zsh/pure" pull
fi
