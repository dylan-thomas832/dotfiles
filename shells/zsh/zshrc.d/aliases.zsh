# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Ensure VIM
alias vi=vim

# List files colorized in long format
alias l="ls -lF --color --show-control-chars"
alias ls="ls -lF --color --show-control-chars"
# List all files colorized in long formation
alias la="ls -lAF --color --show-control-chars"
# List only directories
alias lsd="ls -lF --color | grep --color=never '^d'"

# Colorize `grep` output
alias grep="grep --color=auto"

# Get the week number
alias week="date +%V"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Print public key to screen
alias pubkey="cat ~/.ssh/id_rsa.pub"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
