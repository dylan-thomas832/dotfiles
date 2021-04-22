#####################
#### ZSH Plugins ####
#####################
# Author: Dylan Thomas
# [NOTE]: Loaded before other non-local zsh config files.

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
