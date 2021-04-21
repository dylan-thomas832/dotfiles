####################
#### ZSH Prompt ####
####################
# Author: Dylan Thomas
# [NOTE]: Structure based on:
#   https://github.com/vincentbernat/zshrc/blob/master/rc/prompt.zsh

# My custom prompt config, designed to be sort-of modular. It is designed to
#   be used without any external dependencies. The exception is git
#   integration which uses 'asynch.zsh' repo. However, if one doesn't source
#   my 'vcs.zsh' file, it will default to used the built-in VCS module.

#########################
#### Prompt Features ####
#########################

## Line 1 ##
# Left Prompt:
#   - user@host (only if connected via SSH)
#   - dynamically truncated directory

## Line 2 ##
# Left Prompt:
#   - conda Python environment (if active)
#   - character designating exit code of previous command (zero vs. nonzero)
#   - number of background jobs (if > 0)
#   - prompt symbol if regular user, red '#' if root
# Right Prompt:
#   - git information (via vcs_info_msg_0_) if in a repo

## Sparse Prompt ##
#   - empty line betweeen previous commands and prompt

## Transient Prompt ##
#   - simplified prompt showing previous commands

##########################
#### Modular Segments ####
##########################

# Auto segment handling: use for p10k prompt look
_dt_prompt_segment() {
  local b f
  [[ -n $1 ]] && b="%K{$1}" || b="%k"
  [[ -n $2 ]] && f="%F{$2}" || f="%f"
  [[ -n $3 ]] || return
  if [[ -n $CURRENT_BG && $1 != $CURRENT_BG ]]; then
      print -n " %b$b%F{$CURRENT_BG}${PRCH[end]}$f "
  elif [[ $1 == $CURRENT_BG ]]; then
      print -n " %b$b$f${PRCH[sep]} "
  else
      print -n "%b$b$f "
  fi
  CURRENT_BG=$1
  print -n ${3# *}
}

# Final prompt piece: use for p10k prompt look
_dt_prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%b%k%F{$CURRENT_BG}${PRCH[end]}"
  fi
  print -n "%b%k%f"
  unset CURRENT_BG
}

#########################
#### Custom Segments ####
#########################

# Fancy cwd prompt portion
_dt_prompt_cwd() {
    local -a segs
    local remaining=$(($COLUMNS - ${#${(%):-%n@%M}} - 7))
    local pwd=${(%):-%~}
    # When splitting, we will loose the leading /, keep it if needed
    local leading=${pwd[1]}
    [[ $leading == / ]] || leading=
    segs=(${(s./.)pwd})
    # We try to shorten middle segments if needed (but not the first, not the last)
    case ${#segs} in
        0) print -n "%F{blue}/%f" ;;
        1) print -n "%F{blue}${leading}%B${segs[1]} %b%f " ;;
        *)
            local i=2
            local current
            while true; do
                current=${leading}${(j./.)${segs[1,-2]}}/%B${segs[-1]}
                (( i < ${#segs} )) || break
                (( ${#current} < remaining )) && break
                segs[i]=${segs[i][1]}
                ((i++))
            done
            print -n "%F{blue}${(%):-%${remaining}<${PRCH[ellipsis]}<$current}%b%f"
            ;;
    esac
}

#######################
### Prompt Builders ###
#######################

# Actually set the prompt variables ('PROMPT' & 'RPROMPT') by calling `vcs_info`
# which inserts info into `vcs_info_msg_0`
# This also includes a conda prefix for the current environment
_dt_full_prompt() {
    # Empty line spacer. Not a big deal b/c we are using transient prompt
    print
    # Grabs last bit of path in $CONDA_DEFAULT_ENV. This is updated when `conda activate` is called
    local conda_env="%F{cyan}%B$(basename "$CONDA_DEFAULT_ENV")%b%f"
    # Flips the glyph if in vi command mode
    [ "$KEYMAP" = "vicmd" ] && local glyph='${PRCH[down]}' || local glyph='${PRCH[up]}'
    glyph="%F{blue}$glyph%f"
    # Sets the character based on the previous command exit code
    # Add ' %?' in between `}` and `%f` at the end to print the exit code directly
    local mode="%(?.%F{green}${PRCH[ok]}%f.%F{red}${PRCH[reta]}%f)"
    # Sets the symbol used for user prompt
    local prompt_symbol="%(!.%F{red}#%f.%B%F{magenta}${PRCH[prompt]}%f%b) "
    # Includes the hostname if logged in using SSH
    local ssh_hostname=""
    [[ ! -z "${SSH_CONNECTION}" ]] && ssh_hostname="%n@%m "
    # Includes the number of background jobs currently running if > 0
    local background_jobs="%(1j.%F{yellow}[%j]%f .)"

    # Includes the cwd and 3 trailing components.
    # If the current working directory starts with $HOME, that part is replaced by a ‘~’
    # local cwd="%F{blue}%20<...<%~%f%<<"
    local cwd="$(_dt_prompt_cwd)"
    # print $'${(r:$COLUMNS::\u2500:)}'
    print "$ssh_hostname$cwd"
    print "$conda_env $mode $background_jobs$prompt_symbol"
}

_dt_transient_prompt() {
    # Print 24hr time
    print -n "%F{cyan}%* %f"
    # Print the prompt
    print -n "%(!.%F{red}#%f.%B%F{magenta}${PRCH[prompt]}%f%b) "
}

#############################
### Main Prompt Functions ###
#############################
# [NOTE]: Transient prompt courteous of romkatv:
#   https://github.com/romkatv/powerlevel10k/issues/888#issuecomment-657969840

_dt_setup_transient_prompt() {
    # Localize options, patterns, and traps
    emulate -L zsh

    # Only continue if start of regular command/prompt
    # e.g. Not in "cont", "select", "vared"
    [[ $CONTEXT == start ]] || return 0

    # Catch the return of recursive-edit
    while true; do
        # Call recursive-edit and save the return value
        zle .recursive-edit
        local -i ret=$?
        # Don't break if return code is 0, and ??
        [[ $ret == 0 && $KEYS == $'\4' ]] || break
        # Properly catch EOF / CTRL+D
        [[ -o ignore_eof ]] || exit 0
    done

    # Save current prompt to local variable
    local saved_prompt=$PROMPT
    local saved_rprompt=$RPROMPT
    # Write the transient prompts, and reset prompt
    PS1="%F{cyan}%*%f %(!.%F{red}#%f.%B%F{magenta}${PRCH[prompt]}%f%b) "
    RPROMPT=''
    zle .reset-prompt
    # Reload saved prompt
    PROMPT=$saved_prompt
    RPROMPT=$saved_rprompt

    # Nonzero return calls 'send-break' widget, otherwise command line is accepted
    if (( ret )); then
        zle .send-break
    else
        zle .accept-line
    fi
    return ret
}

_dt_setup_regular_prompt() {
    setopt prompt_subst
    # Exporting is required for overriding root prompt
    export PS1="$(_dt_full_prompt)"
    export PS2="%F{cyan}%_ ${PRCH[prompt]}%f "
    export PS3="%F{cyan}? ${PRCH[prompt]}%f "
    export PS4="%F{cyan}%N | %i ${PRCH[prompt]}%f "
    export PROMPT_EOL_MARK="%B${PRCH[eol]}%b"
    export RPROMPT="$vcs_info_msg_0_"
}

####################
### Prompt Hooks ###
####################

# [TODO]: Scoped necessary?

[[ $USERNAME != "root" ]] && {
    # Hook transient prompt to 'zle-line-init' widget
    add-zle-hook-widget -Uz zle-line-init _dt_setup_transient_prompt
    add-zle-hook-widget -Uz zle-line-init _dt_setup_regular_prompt
}

# Hook prompt setup to 'precmd' function
add-zsh-hook precmd _dt_setup_regular_prompt
