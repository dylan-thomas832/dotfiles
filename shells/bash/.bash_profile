#################################
#### Main .bash_profile File ####
#################################
# Author: Dylan Thomas
# [NOTE]: Run for login shells only

# Put all logic specific to login shells here.

##################################
### Source Common Profile File ###
##################################

source "${HOME}/.profile"

################################
### Source Main .bashrc File ###
################################

source "${HOME}/.bashrc"

. "$HOME/.local/share/../bin/env"
