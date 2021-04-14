### Local bash settings to be sourced last for WSL2

# WSL2-specific display settings.
export DISPLAY=`grep -oP "(?<=nameserver ).+" /etc/resolv.conf`:0.0
export LIBGL_ALWAYS_INDIRECT=1

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/dylan93/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dylan93/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/dylan93/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/dylan93/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
