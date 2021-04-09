# Preferred editor for local and remote sessions
export EDITOR=vim
export VISUAL=vim

# Set XDG Base Directories
[[ -z "${XDG_CONFIG_HOME}" ]] && export XDG_CONFIG_HOME="$HOME/.config"
[[ -z "${XDG_CACHE_HOME}" ]] && export XDG_CACHE_HOME="$HOME/.cache"
[[ -z "${XDG_DATA_HOME}" ]] && export XDG_DATA_HOME="${HOME}/.local/share"

# Set the ZSH cache directory
[[ -d "${XDG_CACHE_HOME}/zsh" ]] && export ZCACHEDIR="${XDG_CACHE_HOME}/zsh"

# Cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE="${XDG_CACHE_HOME}/pip"

# Change history directories for bash and less
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"
export HISTFILE="${XDG_CACHE_HOME}/bash/history"

# Change history directories for redis and sqlite
export SQLITE_HISTORY="${XDG_CACHE_HOME}/sqlite/history"
export REDISCLI_HISTFILE="${XDG_CACHE_HOME}/redis/history"

# Python startup file
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc.py"

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Set conda config file location
export CONDARC="${XDG_CONFIG_HOME}/conda/condarc"

# Set IPython directory
export IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"

# Set pylint home
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"

# Path to manpages
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL='en_US.UTF-8';

# Add ~/.local/bin to PATH if exists
[ -d ~/.local/bin ] && export PATH=~/.local/bin:${PATH}

# Set lib PATH
export LD_LIBRARY_PATH=/usr/lib:/usr/local/lib
# Add ~/.local/lib to Lib PATH if exists
[ -d ~/.local/lib ] && export LD_LIBRARY_PATH=~/.local/lib:${LD_LIBRARY_PATH}
