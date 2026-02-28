#####################
#### ZSH Plugins ####
#####################
# Author: Dylan Thomas
# [NOTE]: Loaded before other non-local zsh config files.

# [NOTE]: ZSH_DJT_USE_* variables will try to load if not empty

# Whether to use pyenv or not. Will echo a message on a failed load.
ZSH_DJT_USE_PYENV=

# Whether to use pipx or not. Will echo "command not found" if failed to load.
ZSH_DJT_USE_PIPX=

# Whether to use uv or not. Will echo "command not found" if failed to load.
ZSH_DJT_USE_UV=1

#######################
### ZSH Git Plugins ###
#######################

#####################
### ZSH Functions ###
#####################
# [TODO]: Are these better loaded directly, or autoloaded?
#        Likely need a ton of functions to make a diff?

# Add custom ZSH functions
[[ -n $ZFUNCSDIR ]] && {
    fpath+=$ZFUNCSDIR
    autoload -Uz $ZFUNCSDIR/*(.:t)
}
# source $ZFUNCSDIR/functions.zsh

##########################
### Custom ZSH Plugins ###
##########################

# [NOTE]: Retrieved via: `pip completion --zsh`
function _pip_completion {
    local words cword
    read -Ac words
    read -cn cword
    reply=( $( COMP_WORDS="$words[*]" \
               COMP_CWORD=$(( cword-1 )) \
               PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
}
compctl -K _pip_completion python -m pip
