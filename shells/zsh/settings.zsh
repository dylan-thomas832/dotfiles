### Standard ZSH Settings File ###
# Author: Dylan Thomas

## Standard Options/Settings
# Load colors and calculator
autoload -Uz colors && colors
autoload -Uz zcalc

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

# Watching other users
#WATCHFMT="%n %a %l from %m at %t."
watch=(notme)         # Report login/logout events for everybody except ourself.
LOGCHECK=60           # Time (seconds) between checks for login/logout activity.
