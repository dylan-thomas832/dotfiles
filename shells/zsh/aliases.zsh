# ZSH specific aliases

# Open git repo in browser
alias gh="xdg-open \`git remote -v | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/git@/http:\/\//' -e's/\.git$//' | sed -E 's/(\/\/[^:]*):/\1\//'\`"

# If the last character of the alias value is a space or tab character, then the next command word following the alias is also checked for alias expansion.
alias sudo='sudo '

# Force ag to use ignore file and not ignore hidden files by default
alias ag="ag --hidden --ignore '.git'"
alias rg="rg --hidden --glob '!.git'"

# Suffix aliases -> applied to end of the line
alias -s log="tail -f"

# Global aliases -> directly replaced on line
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
