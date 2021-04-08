# use this file to run your own startup commands for msys2 bash'

# To add a new vendor to the path, do something like:
# export PATH=${CMDER_ROOT}/vendor/whatever:${PATH}

# Uncomment this to have the ssh agent load with the first bash terminal
# . "${CMDER_ROOT}/vendor/lib/start-ssh-agent.sh"

# Adds git completions
source ~/.config/git/git-completion.bash

# Source standard linux bashrc for common configurations
source ~/.bashrc

####### Aliases

# open epxlorer here
alias e=explorer

# Lazy git
__git_complete g _git

# CD to cmder root
alias cmderr="cd ${CMDER_ROOT}"

###### Exports

# Set terminal appropriately
export TERM='cygwin'

# Allow symlinks
export MSYS=winsymlinks:nativestrict
