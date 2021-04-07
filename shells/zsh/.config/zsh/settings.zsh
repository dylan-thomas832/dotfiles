### Standard ZSH Settings File ###
# Author: Dylan Thomas

## Standard Options/Settings
# Load colors and calculator
autoload -Uz colors zcalc
colors

# Additional options
setopt EXTENDED_GLOB NOMATCH GLOB_STAR_SHORT MENU_COMPLETE
# Remove terminal beep
unsetopt BEEP CORRECT CORRECT_ALL

# Report command running time if it is more than 3 seconds
REPORTTIME=3

## ZSH History Settings
# History File Settings
HISTFILE="${HOME}/.cache/zsh/history"
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

## Completion Settings
# Enable autocompletion
autoload -Uz compinit
zstyle ':completion:*' completer _complete _correct _approximate
zmodload -i zsh/complist

# Initialize completions
compinit -d "${HOME}/.cache/zsh/zcompdump"
_comp_options+=(globdots)  # Include hidden files.

## General Keybinds ##

# Enable incremental search
bindkey "^R" history-incremental-search-backward
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
# Home, End, Delete keys
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
# CTRL + Left/Right
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# Makes CTRL+Z into a toggle switch
ctrlz() {
  if [[ $#BUFFER == 0 ]]; then
    fg >/dev/null 2>&1 && zle redisplay
  else
    zle push-input
  fi
}
zle -N ctrlz
bindkey '^Z' ctrlz

## VIM Mode Settings ##
bindkey -v  # vi mode
export KEYTIMEOUT=40  # Helps with jk

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Use 'jk' to go to command mode
bindkey -M viins 'jk' vi-cmd-mode

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Change cursor depending on vi mode
zle-line-init zle-keymap-select () {
  case ${KEYMAP} in
    vicmd)		echo -ne '\e[1 q' ;;
    viins|main)	echo -ne '\e[5 q' ;;
  esac
}
zle -N zle-keymap-select
zle -N zle-line-init
