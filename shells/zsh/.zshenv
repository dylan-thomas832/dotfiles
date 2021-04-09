# Run for all ZSH instances. Be careful what is set here.

# Skip over global `compinit` call, since we do it anyways
skip_global_compinit=1

# Set environment variables here.

# Force set shell
export SHELL=$(which zsh)

# Set the zsh directory
export ZDOTDIR="~/.config/zsh"
