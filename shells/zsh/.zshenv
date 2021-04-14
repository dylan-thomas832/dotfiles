# Run for all ZSH instances. Be careful what is set here.

# Skip over global `compinit` call, since we do it anyways
skip_global_compinit=1

# Force set shell
export SHELL=$(which zsh)

# Setup common environment variables
source "${HOME}/.config/sh/custom/environment.sh"
