###################################
#### General ZSH Settings File ####
###################################
# Author: Dylan Thomas

############################
### Standard ZSH Options ###
############################

## Various options
# interactivecomments:    Allow comments in interactive shell
# always_to_end:          Moves cursor to end of word on completion
# auto_pushd:             Make cd push the old directory onto the directory stack
# pushd_ignore_dups:      Don’t push multiple copies of the same directory onto the directory stack
# cdable_vars:            If arg to `cd` is not a directory, try to expand it (aliases and bookmarks)

## Globbing options
# extended_glob:          Improved filename generation on CLI
# nomatch:                Print error is globbing has no matches
# glob_star_short:        Shorthand '**' for '**/*'
# no_case_glob:           Case insensitive globbing

## History options
# inc_append_history:     Add commands to history as they are entered, don't wait for shell to exit
# extended_history:       Also remember command start time and duration
# hist_ignore_all_dups:   Do not keep duplicate commands in history
# hist_ignore_space:      Do not remember commands that start with a whitespace
# share_history:          Share history across multiple zsh sessions
# hist_reduce_blanks:     Remove unnecessary blank spaces from history commands 'cd  ~' -> 'cd ~'
# hist_verify:            Don't auto run commands on history substitution
# hist_no_store:          Don't store calls to `history` or `fc` in the history
setopt                      \
    interactivecomments     \
    always_to_end           \
    auto_pushd              \
    pushd_ignore_dups       \
    cdable_vars             \
    extended_glob           \
    nomatch                 \
    glob_star_short         \
    no_case_glob            \
    inc_append_history      \
    extended_history        \
    hist_ignore_all_dups    \
    hist_ignore_space       \
    share_history           \
    hist_reduce_blanks      \
    hist_verify             \
    hist_no_store           \

## Unset various options
# beep:                   Remove terminal beep
# correct:                Stop zsh command spell correction
# correct_all:            Stop zsh argument spell correction
# menu_complete:          Don't autoselect the first completion entry
# flow_control:           Don't use flow control which block ^S ^Q
unsetopt                    \
    beep                    \
    correct                 \
    correct_all             \
    menu_complete           \
    flow_control            \

#############################
### History File Settings ###
#############################

HISTFILE="${ZCACHEDIR}/history"
HISTSIZE=10000
SAVEHIST=10000

##############################
### Miscellaneous Settings ###
##############################

# Report command running time if it is more than 3 seconds
REPORTTIME=3

# Limit directory stack size
DIRSTACKSIZE=16

# Watching other users
# WATCHFMT="%n %a %l from %m at %t."
watch=(notme)         # Report login/logout events for everybody except ourself.
LOGCHECK=60           # Time (seconds) between checks for login/logout activity.
