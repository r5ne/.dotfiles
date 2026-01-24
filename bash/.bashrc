#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Default colors for ls and grep
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Include additional files if they exist
if [ -f $HOME/.bashrc-niri ]; then
    source $HOME/.bashrc-niri
fi

if [ -f $HOME/.bashrc-yazi ]; then
    source $HOME/.bashrc-yazi
fi
