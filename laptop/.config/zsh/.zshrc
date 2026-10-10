# read after ~/.zprofile

# history opts
setopt append_history share_history # share_history includes inc_append_history
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_CACHE_HOME/zsh_history" # move histfile to cache
