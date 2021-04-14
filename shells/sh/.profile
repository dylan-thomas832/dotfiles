# Set environment variables
source "${HOME}/.config/sh/custom/environment.sh"

# Add existing ssh keys to ssh-agent
eval "$(ssh-agent)"
ssh-add
