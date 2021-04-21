###########################
#### Main .zshenv File ####
###########################
# Author: Dylan Thomas
# [NOTE]: Run for all ZSH instances. Be careful what is set here.

# Put settings common to shells of all types.

###########################
### Global ZSH Settings ###
###########################

# Skip over global `compinit` call since we do it anyways.
# [NOTE]: This might be Ubuntu specific
skip_global_compinit=1

# Force set shell
export SHELL=$(which zsh)

##############################
### Source Common ENV File ###
##############################

# Setup common environment variables
source "${HOME}/.config/sh/custom/environment.sh"

#####################
### Ensure Unique ###
#####################

typeset -U path
typeset -U manpath
typeset -TU LD_LIBRARY_PATH ld_library_path

#########################
### ZSH ENV Variables ###
#########################

# Set the ZSH cache directory
[ -d "$XDG_CACHE_HOME/zsh" ] && export ZCACHEDIR="$XDG_CACHE_HOME/zsh"

# Set the ZSH vendor directory
[ -d "$ZDOTDIR/vendor" ] && export ZVENDORDIR="$ZDOTDIR/vendor"

# Set the ZSH functions directory
[ -d "$ZDOTDIR/zfuncs" ] && export ZFUNCSDIR="$ZDOTDIR/zfuncs"

# Set the ZSH completions directory
[ -d "$ZDOTDIR/completions" ] && export ZCOMPLETIONSDIR="$ZDOTDIR/completions"
