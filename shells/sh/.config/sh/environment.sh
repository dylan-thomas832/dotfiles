# Preferred editor for local and remote sessions
export EDITOR=vim
export VISUAL=vim

# Cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE="$HOME/.cache/pip"

# XDG Base Directory
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

# Change history directories for bash and less
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"
export HISTFILE="${XDG_CACHE_HOME}/bash/history"

# Change history directories for redis and sqlite
export SQLITE_HISTORY="${XDG_CACHE_HOME}/sqlite/history"
export REDISCLI_HISTFILE="${XDG_CACHE_HOME}/redis/history"

# Python startup file
export PYTHONSTARTUP="$HOME/.config/python/pythonrc.py"

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Set conda config file location
export CONDARC="$HOME/.config/conda/condarc"

# Set IPython directory
export IPYTHONDIR="$HOME/.config/ipython"

# Set pylint home
export PYLINTHOME="${XDG_DATA_HOME}/pylint"

# Path to manpages
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL='en_US.UTF-8';
