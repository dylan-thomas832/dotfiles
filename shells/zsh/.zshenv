###########################
#### Main .zshenv File ####
###########################
# Author: Dylan Thomas
# [NOTE]: Run for all ZSH instances. Be careful what is set here.

# Put settings common to shells of all types.

###########################
### Global ZSH Settings ###
###########################

# Skip over global `compinit` call, since we do it anyways
skip_global_compinit=1

# Force set shell
export SHELL=$(which zsh)

##############################
### Source Common ENV File ###
##############################

# Setup common environment variables
source "${HOME}/.config/sh/custom/environment.sh"

#########################
### ZSH ENV Variables ###
#########################

# Set the ZSH cache directory
[ -d "$XDG_CACHE_HOME/zsh" ] && export ZCACHEDIR="$XDG_CACHE_HOME/zsh"

# Set the ZSH vendor directory
[ -d "$ZDOTDIR/vendor" ] && export ZVENDORDIR="$ZDOTDIR/vendor"
