# Loaded once on login before ~/.zshrc

# XDG specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Add local binaries to path
export PATH="$HOME/.local/bin:$PATH"

# QT
export QT_QPA_PLATFORMTHEME=qt6ct

# Enforce XDG specification with other programs

# Development tools
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NIMBLE_DIR="$XDG_DATA_HOME/nimble"

export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$GOPATH/bin"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"

export PYTHONUSERBASE="$XDG_DATA_HOME/python"
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
export PYTHONCACHEPREFIX="$XDG_CACHE_HOME/python"
export RUFF_CACHE_DIR="$XDG_CACHE_HOME/ruff"

export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
_JAVA_OPTIONS+=" -Djavafx.cachedir=$XDG_CACHE_HOME/openjfx"

export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export ANDROID_USER_HOME="$XDG_DATA_HOME/android"
export NUGET_PACKAGES="$XDG_CACHE_HOME/NugetPackages"
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet

# OS software
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export FFMPEG_DATADIR="$XDG_CONFIG_HOME/ffmpeg"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"

# Personal software
export DISCORD_USER_DATA_DIR="$XDG_DATA_HOME"

export GVIMINIT='let $MYGVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/gvimrc" : "$XDG_CONFIG_HOME/nvim/init.gvim" | so $MYVIMRC'
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'

export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship.toml"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship"

# Start the niri compositor on login on tty1
[ -f "$XDG_CONFIG_HOME/shell/start-niri" ] && source "$XDG_CONFIG_HOME/shell/start-niri"
