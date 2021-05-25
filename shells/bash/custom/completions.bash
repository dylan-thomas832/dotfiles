#############################
#### ZSH Completion File ####
#############################
# Author: Dylan Thomas

# Define all completion-specific settings/functions here, then initialize the
#   completion system.

#########################
### System Completion ###
#########################

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        source /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        source /etc/bash_completion
    fi
fi

###########################
### Completion Settings ###
###########################

############################
### Completion Functions ###
############################

if [ -n $OS ]; then
    if [ $OS != "Windows_NT" ]; then
        source "$XDG_CONFIG_HOME/bash/completions/pip.bash"
        source "$XDG_CONFIG_HOME/bash/completions/cargo.bash"
        source "$XDG_CONFIG_HOME/bash/completions/rustup.bash"
    fi
fi
