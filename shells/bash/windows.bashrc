
# test for an interactive shell. there is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
  # shell is non-interactive. be done now!
  return
fi

# Source machine-specific bashrc file
if [ -f ~/.bashrc_local ]; then
  source ~/.bashrc_local
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval "$('/c/Users/Dylan/miniconda3/Scripts/conda.exe' 'shell.bash' 'hook')"
# <<< conda initialize <<<

