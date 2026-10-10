# read after ~/.zprofile

# load completion
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors

# configure completion
zstyle ':completion:*' menu select # open cmp menu with tab
zstyle ':completion:*' special-dirs true # show . and .. in cmp menu
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


# keybinds
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line

bindkey "^j" backward-word
bindkey "^k" forward-word
bindkey "^H" backward-kill-word

bindkey "^J" history-search-forward
bindkey "^K" history-search-backward

# set up prompt
autoload -Uz vcs_info
precmd() { vcs_info } # load the vcs_info_msg_0_ env var (executed before each prompt)
setopt prompt_subst # allow expanding environment variables in the prompt
zstyle ':vcs_info:git*' formats ' [%b]'
# PROMPT='%~%f%F{yellow}${vcs_info_msg_0_}%f%(?.%F{white} $%f.%F{red} $%f) '

# syntax highlighting via zsh-patina
eval "$(zsh-patina activate)"
