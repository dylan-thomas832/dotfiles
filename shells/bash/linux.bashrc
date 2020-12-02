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

# load zsh init
if [ -f ~/.zshrc ]; then
  exec zsh
fi

# Load local bashrc instance, mainly for conda
if [-f ~/.bashrc_local_after]; then
  source ~/.bashrc_local_after
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
