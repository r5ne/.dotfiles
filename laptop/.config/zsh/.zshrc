# read after ~/.zprofile

# Uncomment alongside the bottom line to enable shell startup time profiling
# zmodload zsh/zprof

# source aliases
[ -f "$XDG_CONFIG_HOME/shell/aliases" ] && source "$XDG_CONFIG_HOME/shell/aliases"

# load completion
zmodload zsh/complist
autoload -Uz colors && colors
autoload -Uz compinit

# only reload completion caches every 2 hours
_comp_files=("$ZDOTDIR/.zcompdump"(N.mh-2))
if (( $#_comp_files )); then
    echo "Recaching completions."
    compinit
else
    compinit -C # skip recaching completion
fi

# configure completion
zstyle ':completion:*' menu select # open cmp menu with tab
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # enable colors in cmp menu
setopt auto_menu menu_complete # autocomplete first match
setopt no_case_glob no_case_match # make autocomplete case-insensitive
setopt globdots # include dotfiles
setopt interactive_comments # allow comments

# history opts
setopt append_history share_history # share_history includes inc_append_history
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_CACHE_HOME/zsh_history" # move histfile to cache

# set up prompt
fpath+=("$ZDOTDIR/pure") # must load prompt path before loading promptinit
autoload -Uz promptinit && promptinit
prompt pure

# old prompt
# autoload -Uz vcs_info
# precmd() { vcs_info } # load the vcs_info_msg_0_ env var (executed before each prompt)
# setopt prompt_subst # allow expanding environment variables in the prompt
# zstyle ':vcs_info:git*' formats ' [%b]'
# PROMPT='%~%f%F{yellow}${vcs_info_msg_0_}%f%(?.%F{white} $%f.%F{red} $%f) '

# keybinds
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line

bindkey "^j" backward-word
bindkey "^k" forward-word
bindkey "^H" backward-kill-word

bindkey "^J" history-search-forward
bindkey "^K" history-search-backward

# syntax highlighting via zsh-patina
# must be at the bottom of the file
eval "$(zsh-patina activate)"

# activate the mise development tool manager
eval "$(mise activate zsh)"

# Uncomment along with the line near the top of the file to profile shell startup time
# zprof
