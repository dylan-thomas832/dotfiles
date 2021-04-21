##############################
#### Common .profile File ####
##############################
# Author: Dylan Thomas
# [NOTE]: This file should be POSIX compliant

# This file is sourced by 'sh', and manually pointed to for 'bash' and 'zsh'

# Set environment variables
. "${HOME}/.config/sh/custom/environment.sh"

# Add existing ssh keys to ssh-agent
eval "$(ssh-agent)"
ssh-add
