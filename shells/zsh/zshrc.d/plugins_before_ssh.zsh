# Load autocompletion, colors, and vcs info

autoload -U compinit colors vcs_info zcalc
colors
compinit

# Report command running time if it is more than 3 seconds
REPORTTIME=3
# Keep a lot of history
HISTFILE=~/.zhistory
HISTSIZE=5000
SAVEHIST=5000
# Add commands to history as they are entered, don't wait for shell to exit
setopt INC_APPEND_HISTORY
# Also remember command start time and duration
setopt EXTENDED_HISTORY
# Do not keep duplicate commands in history
setopt HIST_IGNORE_ALL_DUPS
# Do not remember commands that start with a whitespace
setopt HIST_IGNORE_SPACE
# Correct spelling of all arguments in the command line
setopt CORRECT_ALL
# Enable autocompletion
zstyle ':completion:*' completer _complete _correct _approximate 
# Enable incremental search
bindkey '^R' history-incremental-search-backward
