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

# Add custom ZSH functions
[[ -n $ZFUNCSDIR ]] && {
    fpath+=$ZFUNCSDIR
    fns=($ZFUNCSDIR/**/*(.))
    (( $#fns )) && autoload -Uz "$fns[@]"
}

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
