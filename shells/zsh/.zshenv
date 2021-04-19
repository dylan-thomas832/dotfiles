# Run for all ZSH instances. Be careful what is set here.

# Skip over global `compinit` call, since we do it anyways
skip_global_compinit=1

# Force set shell
export SHELL=$(which zsh)

# Setup common environment variables
source "${HOME}/.config/sh/custom/environment.sh"

# ZSH-specific environment variables

# Set the ZSH cache directory
[ -d "$XDG_CACHE_HOME/zsh" ] && export ZCACHEDIR="$XDG_CACHE_HOME/zsh"

# Set the ZSH vendor directory
[ -d "$ZDOTDIR/vendor" ] && export ZVENDORDIR="$ZDOTDIR/vendor"
