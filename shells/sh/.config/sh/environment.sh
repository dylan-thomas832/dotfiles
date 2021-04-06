# Preferred editor for local and remote sessions
export EDITOR=vim
export VISUAL=vim

# Cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE="$HOME/.cache/pip"

# Python startup file
export PYTHONSTARTUP="$HOME/.config/python/pythonrc.py"

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Set conda config file location
export CONDARC="$HOME/.config/conda/condarc"

# Set IPython directory
export IPYTHONDIR="$HOME/.config/ipython"

# Path to manpages
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL='en_US.UTF-8';
