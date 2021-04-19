# Preferred editor for local and remote sessions
export EDITOR=vim
export VISUAL=vim

# Set XDG Base Directories
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME/.cache"
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME/.local/share"

# Cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE="$XDG_CACHE_HOME/pip"

# Change history directories for bash and less
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export HISTFILE="$XDG_CACHE_HOME/bash/history"

# Change history directories for redis and sqlite
export SQLITE_HISTORY="$XDG_CACHE_HOME/sqlite/history"
export REDISCLI_HISTFILE="$XDG_CACHE_HOME/redis/history"

# Python startup file
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc.py"

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Set conda config file location
export CONDARC="$XDG_CONFIG_HOME/conda/condarc"

# Set IPython directory
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"

# Set pylint home
export PYLINTHOME="$XDG_CACHE_HOME/pylint"

# Set jupyter config home
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"

# Set the readline config file
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"

# Path to manpages
export MANPATH="/usr/local/man:$MANPATH"

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Rust-specific settings
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# Go-specific settings
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$HOME/.local/bin"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL='en_US.UTF-8';

# Save local bin and lib directories
export LOCAL_BIN="$HOME/.local/bin"
export LOCAL_LIB="$HOME/.local/lib"

## Path Manipulation. Allows adding to paths in POSIX shell without duplication.
## See: https://unix.stackexchange.com/a/124447
prepend_path() { case ":${PATH:=$1}:" in *:"$1":*) ;; *) PATH="$1:$PATH" ;; esac; }
append_path() { case ":${PATH:=$1}:" in *:"$1":*) ;; *) PATH="$PATH:$1" ;; esac; }

# Add LOCAL_BIN to PATH if exists
[ -d "$LOCAL_BIN" ] && prepend_path "$LOCAL_BIN"

# Set lib PATH, and add LOCAL_LIB if it exists
[ -z "$LD_LIBRARY_PATH" ] && export LD_LIBRARY_PATH="/usr/local/lib:/usr/lib"
case ":${LD_LIBRARY_PATH:=$LOCAL_LIB}:" in
    *:"$LOCAL_LIB":*)  ;;
    *) LD_LIBRARY_PATH="$LOCAL_LIB:$LD_LIBRARY_PATH"  ;;
esac
