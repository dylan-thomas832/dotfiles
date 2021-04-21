##########################
#### ZSH Aliases File ####
##########################
# Author: Dylan Thomas

# These are aliases defined specifically for interactive ZSH shells.
# Please read the section for 'alias' for context:
#    http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html#Shell-Builtin-Commands

########################
### Standard Aliases ###
########################

# Open git repo in browser
alias gh="xdg-open \`git remote -v | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/git@/http:\/\//' -e's/\.git$//' | sed -E 's/(\/\/[^:]*):/\1\//'\`"

# If the last character of the alias value is a space or tab character, then the next command word following the alias is also checked for alias expansion.
alias sudo='sudo '

# Zcalc in floating point mode
alias calc='zcalc -f'
alias zcalc='zcalc -f'

# Force ag to use ignore file and not ignore hidden files by default
alias ag="ag --hidden --ignore '.git'"
alias rg="rg --hidden --glob '!.git'"

######################
### Suffix Aliases ###
######################
# [NOTE]: Applied to end of the command word. Be careful.

# If command is "filename.log" it will call `tail -f` on "filename.log"
alias -s log="tail -f"

######################
### Global Aliases ###
######################
# [NOTE]: Aliases expanded even if they are not in the command position. Be careful.

# cd laziness
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
