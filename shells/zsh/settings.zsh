### Standard ZSH Settings File ###
# Author: Dylan Thomas

## Standard Options/Settings
# Load colors and calculator
autoload -Uz colors zcalc
colors

# Set globbing options
# extended_glob:          Improved filename generation on CLI
# nomatch:                Print error is globbing has no matches
# glob_star_short:        Shorthand '**' for '**/*'
# no_case_glob:           Case insensitive globbing
setopt extended_glob nomatch glob_star_short no_case_glob

# Set various options
# interactivecomments:    Allow comments in interactive shell
# always_to_end:          Moves cursor to end of word on completion
# auto_pushd:             Make cd push the old directory onto the directory stack
# pushd_ignore_dups:      Don’t push multiple copies of the same directory onto the directory stack
setopt interactivecomments always_to_end auto_pushd pushd_ignore_dups

# Unset various options
# beep:                   Remove terminal beep
# correct:                Stop zsh command spell correction
# correct_all:            Stop zsh argument spell correction
# menu_complete:          Don't autoselect the first completion entry
unsetopt beep correct correct_all menu_complete

# Report command running time if it is more than 3 seconds
REPORTTIME=3

## ZSH History Settings
# History File Settings
HISTFILE="${ZCACHEDIR}/history"
HISTSIZE=10000
SAVEHIST=10000

# Various history options
# inc_append_history:     Add commands to history as they are entered, don't wait for shell to exit
# extended_history:       Also remember command start time and duration
# hist_ignore_all_dups:   Do not keep duplicate commands in history
# hist_ignore_space:      Do not remember commands that start with a whitespace
# hist_expire_dups_first: Delete duplicates first when HISTFILE size exceeds HISTSIZE
# share_history:          Share history across multiple zsh sessions
# append_history:         Append to history
# hist_reduce_blanks:     Remove blank lines from history
# hist_repair:            Don't auto run commands on history substitution
setopt inc_append_history extended_history hist_ignore_all_dups hist_ignore_space
setopt hist_expire_dups_first share_history append_history hist_reduce_blanks hist_verify

## Completion Settings

# Add completers....
zstyle ':completion:*' completer _complete _correct _approximate
# Allows dircolors to be used in completion menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Use menu completion highlighting
zstyle ':completion:*' menu select
# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZCACHEDIR
# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'
# ... unless we really want to.
zstyle '*' single-ignored show
# Allow partial completion of paths
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
# Load completion list
zmodload -i zsh/complist

# Initialize completions
autoload -Uz compinit
compinit -C -d "${ZCACHEDIR}/zcompdump-${HOST/.*/}-${ZSH_VERSION}"
_comp_options+=(globdots)  # Include hidden files.

# Automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit

## General Keybinds ##

# Makes searching history go to the end of the line
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# Enable incremental search
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
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

# Use 'jk' to go to command mode
bindkey -M viins 'jk' vi-cmd-mode

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Change cursor & glyph depending on vi mode
zle-line-init zle-keymap-select () {
  # Setup and reset prompt on mode switch
  _setup_ps1
  zle reset-prompt
  # Switch cursor
  case ${KEYMAP} in
    vicmd)      echo -ne '\e[1 q' ;;
    viins|main) echo -ne '\e[5 q' ;;
  esac
}
zle -N zle-keymap-select
zle -N zle-line-init

# Watching other users
#WATCHFMT="%n %a %l from %m at %t."
watch=(notme)         # Report login/logout events for everybody except ourself.
LOGCHECK=60           # Time (seconds) between checks for login/logout activity.
