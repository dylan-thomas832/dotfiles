# vi mode
bindkey -v
export KEYTIMEOUT=40

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

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Use 'jk' to go to command mode
bindkey -M viins 'jk' vi-cmd-mode  # @todo - THIS DOES NOT WORK?

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

# Additional options
setopt EXTENDED_GLOB NOMATCH GLOB_STAR_SHORT MENU_COMPLETE
# Remove terminal beep
unsetopt BEEP CORRECT CORRECT_ALL

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# Colors
eval $(dircolors -b ${HOME}/.dircolors)
