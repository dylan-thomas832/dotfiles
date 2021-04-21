#############################
#### Common Aliases File ####
#############################
# Author: Dylan Thomas
# [NOTE]: This file should be POSIX compliant

# Common aliases defined for all interactive shells

# Guard to prevent sourcing multiple times
[ -n "$_dt_shared_alias_loaded" ] && return 0

##################
### Navigation ###
##################

#######################
### Common Programs ###
#######################

# Ensure VIM
alias vi=vim

# Git laziness
alias g=git

################
### Colorize ###
################

# List files colorized in long format
alias l="ls -lFh --color --show-control-chars --group-directories-first"
alias ll='ls -lh --group-directories-first'
alias ls="ls -lFh --color --show-control-chars  --group-directories-first"
# List all files colorized in long formation
alias la="ls -lAFh --color --show-control-chars  --group-directories-first"
# List only directories
alias lsd="ls -lFh --color | grep --color=never '^d'"

# Colorize dir
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# Colorize `grep` output
alias grep="grep --color=auto"
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#########################
### File Manipulation ###
#########################

# Safer copy, move, remove
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

######################
### Miscellaneous ####
######################

# Get the week number
alias week="date +%V"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL}"

# Easy clipboard command
alias clipboard='xclip -selection clipboard'

# Print each PATH entry on a separate line
alias ppath='echo -e ${PATH//:/\\n}'

# Guard to prevent sourcing multiple times
_dt_shared_alias_loaded=y
