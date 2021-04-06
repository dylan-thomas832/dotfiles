# Syntax highlighting from zsh-users
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Substring search from zsh-users
source ~/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Load autocompletion, colors, and vcs info
autoload -Uz colors vcs_info zcalc
colors

# Report command running time if it is more than 3 seconds
REPORTTIME=3
# Keep a lot of history
HISTFILE=~/.config/zsh/zhistory
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
autoload -Uz compinit
zstyle ':completion:*' completer _complete _correct _approximate menu select
zmodload -i zsh/complist

# Initialize completions
ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.config/zsh/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
compinit -i -d "${ZSH_COMPDUMP}"
_comp_options+=(globdots)               # Include hidden files.
