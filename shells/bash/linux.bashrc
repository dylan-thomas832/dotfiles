# ~/.bashrc
#
# this file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output. so make sure this doesn't display
# anything or bad things will happen !

# test for an interactive shell. there is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
  # shell is non-interactive. be done now!
  return
fi

# Source additional sh configs
for config in "${HOME}"/.config/sh/*.sh ; do
  source "${config}"
done

# History settings
HISTCONTROL=ignoreboth
HISTSIZE= HISTFILESIZE=2000
shopt -s histappend

# Additional options
shopt -s checkwinsize globstar autocd

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Configure git prompt
GIT_PS1_SHOWDIRTYSTATE=yes
GIT_PS1_SHOWSTASHSTATE=yes
GIT_PS1_SHOWUNTRACKEDFILES=yes
GIT_PS1_SHOWUPSTREAM=verbose
GIT_PS1_HIDE_IF_PWD_IGNORED=yes

export PROMPT_COMMAND=__prompt_command

function __prompt_command() {
  local EXIT=$?
  local RED='\[\033[01;31m\]'
  local GREEN='\[\033[01;32m\]'
  local BLUE='\[\033[01;34m\]'
  local MAGENTA='\[\033[01;35m\]'
  local NONE='\[\033[00m\]'
  local EXIT_PRE=

  if [ "${color_prompt}" = yes ]; then
    PS1="${GREEN}\u@\h${NONE}:${BLUE}\w${MAGENTA}"
    EXIT_PRE="${RED}[${EXIT}] "
  else
    PS1="\u@\h:\w"
    EXIT_PRE="[${EXIT}] "
  fi

  if [ ${EXIT} != 0 ] ; then
    PS1="${EXIT_PRE}${PS1}"
  fi

  __git_ps1 "${PS1}" "${NONE}\n\$"

  return ${EXIT}
}

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 2>/dev/null ) )
}
complete -o default -F _pip_completion python -m pip
# pip bash completion end

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Load local bashrc instance, mainly for conda
if [ -f ~/.bashrc_local_after ]; then
  source ~/.bashrc_local_after
fi

# Source fzf if it exists
if [ -f ~/.fzf.bash ]; then
  source ~/.fzf.bash
fi
