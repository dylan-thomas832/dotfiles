# Run for all ZSH instances. Be careful what is set here.

# This is specifically for the $HOME directory, so it can properly
#   set the $ZDOTDIR and then source the .zshenv there. No other
#   settings/options/variables should be touched here.

# Set the zsh directory, and source the zshenv there
export ZDOTDIR=$HOME/.config/zsh
source $ZDOTDIR/.zshenv
