# Set environment variables
source "${HOME}/.config/sh/environment.sh"

# Add existing ssh keys to ssh-agent
eval "$(ssh-agent)"
ssh-add
