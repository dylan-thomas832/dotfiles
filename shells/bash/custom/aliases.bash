##########################
#### ZSH Aliases File ####
##########################
# Author: Dylan Thomas

##################
### Navigation ###
##################

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

#####################
### Miscellaneous ###
#####################

# Open git repo in browser
alias gh="xdg-open \`git remote -v | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/git@/http:\/\//' -e's/\.git$//' | sed -E 's/(\/\/[^:]*):/\1\//'\`"
