### Dylan's ZSH prompt. 
# Structure pulled from: https://github.com/vincentbernat/zshrc/blob/master/rc/prompt.zsh

# Autoload ZSH add hook function
autoload -Uz add-zsh-hook

# Turn on prompt substitution
setopt prompt_subst

_dt_prompt_preexec () {
    # TOOD: Investigate fc -l -1

    # printf '%-*s' $COLUMNS "Output:"
    # # Removes/eats previous prompt
    # print
    printf "\033[2A\033[2K"
    # # print $1
    # # print $2
    # # print $3
    # # printf "\033[2A\033[2K"
    # # not sure
    0="${1//\\/\\\\\\\\}"
    0="${0//\\n/\\\\n}"
    0="${0//\$/\\\\$}"
    0="${0//\`/\\\\\`}"
    0="${0//\%/%%}"
    formatted_cmd="%* %(!.%F{red}#%f.%F{magenta}${PRCH[prompt]}%f) ${0//\\/\\\\}"
    # middle bit is last line of final prompt with %1~
    # print -P -- "%* %B%F{blue}%1~%f%f%b %F{magenta}${PRCH[prompt]}%f"" ${0//\\/\\\\}"
    print -P -- $formatted_cmd
    # [[ -z $1 ]] && printf "\033[2A\033[2K"
    # print -P -- "%* %F{magenta}${PRCH[prompt]}%f ${0//\\/\\\\}"
    # read -sdR $'pos_before?\e[6n'
    # print moved us down a line
    printf "\033[2K"
    # oldcmd=$1
    # [[ -n $1 ]] && printf "\033[2K"
}

_dt_prompt_precmd () {
    # # Removes/eats previous prompt
    # print
    # printf "\033[2K"
    # # not sure
    # printf "\033[2A\033[2K"
    # read -sdR $'pos_after?\e[6n'
    # [[ $pos_after != $pos_before ]] || printf '\r'
    # 0="${1//\\/\\\\\\\\}"
    # 0="${0//\\n/\\\\n}"
    # 0="${0//\$/\\\\$}"
    # 0="${0//\`/\\\\\`}"
    # 0="${0//\%/%%}"
    # middle bit is last line of final prompt with %1~
    # print -P -- "%* %B%F{blue}%1~%f%f%b %F{magenta}${PRCH[prompt]}%f"" ${0//\\/\\\\}"
    [[ -z $formatted_cmd ]] && printf "\033[2A\033[2K" && print -P -- "%* %(!.%F{red}#%f.%F{magenta}${PRCH[prompt]}%f) "
    unset formatted_cmd
    # printf "\033[2K"
    # print moved us down a line
    # print
}

# Segment handling
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

# Final prompt piece
_dt_prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%b%k%F{$CURRENT_BG}${PRCH[end]}"
  fi
  print -n "%b%k%f"
  unset CURRENT_BG
}

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

# Actually set the prompt variables ('PROMPT' & 'RPROMPT') by calling `vcs_info`
# which inserts info into `vcs_info_msg_0`
# This also includes a conda prefix for the current environment
_dt_simple_prompt() {
    # Grabs last bit of path in $CONDA_DEFAULT_ENV. This is updated when `conda activate` is called
    CONDA_CURR_ENV=$(basename "$CONDA_DEFAULT_ENV")
    # Flips the glyph if in vi command mode
    [ "x$KEYMAP" = "xvicmd" ] && local glyph=${PRCH[down]} || local glyph=${PRCH[up]}
    # Sets the glyph direction for vi-mode and color for the previous command exit code
    # Add `"%? "` in between `}` and `)` to print the exit code directly
    local mode="%(?.%F{blue}.%F{red})$glyph%f"
    # Sets the symbol used for user prompt
    local prompt_symbol="%(!.%F{red}#%f.%B%F{magenta}${PRCH[prompt]}%f%b) "
    # Includes the hostname if logged in using SSH
    local ssh_hostname=""
    [[ ! -z "${SSH_CONNECTION}" ]] && ssh_hostname="%n@%m "
    # Includes the number of background jobs currently running if > 0
    local background_jobs="%(1j.%F{cyan}[%j]%f .)"

    # Includes the cwd and 3 trailing components.
    # If the current working directory starts with $HOME, that part is replaced by a ‘~’
    # local cwd="%F{blue}%~%f"
    local cwd="$(_dt_prompt_cwd)"
    # print $'${(r:$COLUMNS::\u2500:)}'
    print "$ssh_hostname$cwd"
    print -n "%F{green}%B$CONDA_CURR_ENV%b%f $mode $background_jobs$prompt_symbol"
}

_dt_setup_prompt () {
    # export PS1=$'${(r:$COLUMNS::\u2500:)}''$(_dt_simple_prompt)'
    # Exporting is required for overriding root prompt
    export PS1="$(_dt_simple_prompt)"
    export PS2="%Scont'd%s %F{cyan}${PRCH[prompt]}%f"
    export PS3="$(_dt_prompt_segment cyan default "?"; _dt_prompt_end) "
    export PS4="$(_dt_prompt_segment white black "%N"; _dt_prompt_segment blue default "%i"; _dt_prompt_end) "
    export PROMPT_EOL_MARK="%B${PRCH[eol]}%b"
    export RPROMPT="$vcs_info_msg_0_"
}


# Call initial prompt setup
add-zsh-hook preexec _dt_prompt_preexec
add-zsh-hook precmd _dt_prompt_precmd
add-zsh-hook precmd _dt_setup_prompt
