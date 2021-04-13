### ZSH Plugins loaded before compinit ###
# Author: Dylan Thomas

## ZSH function plugins

## Custom ZSH plugins

# ZSH completion for pip
# Retrieved via: `pip completion --zsh`
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
}
compctl -K _pip_completion python -m pip
