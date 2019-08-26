# Local binaries. First should already be added
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Add Anaconda to path
export PATH="$HOME/anaconda3/bin:$PATH"

# pip should only run if there is a virtualenv currently activated
# export PIP_REQUIRE_VIRTUALENV=true

# Cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE="$HOME/.pip/cache"

# Python startup file
export PYTHONSTARTUP="$HOME/.pythonrc"

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Useful for X11 forwarding
export DISPLAY=:0

# Shared library path
export LD_LIBRARY_PATH="/usr/lib:/usr/local/lib:~/.local/lib$LD_LIBRARY_PATH"

# Path to manpages
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL='en_US.UTF-8';

# ssh keys
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# Ensure we use zsh
export SHELL=zsh

# Colors
eval $(dircolors -b ${HOME}/.dircolors)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='vim'
fi

