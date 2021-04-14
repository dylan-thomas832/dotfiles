### Local bash settings to be sourced last for WSL2

# WSL2-specific display settings.
export DISPLAY=`grep -oP "(?<=nameserver ).+" /etc/resolv.conf`:0.0
export LIBGL_ALWAYS_INDIRECT=1
