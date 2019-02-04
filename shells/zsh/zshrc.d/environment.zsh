# Add Anaconda to path
# export PATH=$HOME/anaconda2/bin:$PATH
# export PATH=$HOME/anaconda3/bin:$PATH

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# Cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# Python startup file
export PYTHONSTARTUP=$HOME/.pythonrc

# Useful for X11 forwarding
export DISPLAY=:0

# Shared library path
export LD_LIBRARY_PATH=/usr/lib:/usr/local/lib

# Local binaries. First should already be added
# export PATH=/usr/local/bin:$PATH
# export PATH="$HOME/.local/bin:$PATH"

# Path to manpages
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# ssh keys
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='vim'
fi

