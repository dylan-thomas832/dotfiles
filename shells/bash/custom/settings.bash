###################################
#### General ZSH Settings File ####
###################################
# Author: Dylan Thomas

#############################
### History File Settings ###
#############################
export HISTFILE="$XDG_CACHE_HOME/bash/history"
HISTCONTROL=ignoreboth
HISTSIZE= HISTFILESIZE=2000
shopt -s histappend

#############################
### Standard Bash Options ###
#############################
shopt -s checkwinsize globstar autocd

# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"
