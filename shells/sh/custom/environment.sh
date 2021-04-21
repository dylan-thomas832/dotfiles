#########################
#### Common ENV File ####
#########################
# Author: Dylan Thomas
# [NOTE]: This file should be POSIX compliant

# Common environment variables to be set in all shells

# Guard to prevent sourcing multiple times
[ -n "$_dt_shared_env_loaded" ] && return 0

############################
### XDG Base Directories ###
############################

[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME/.cache"
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME/.local/share"

#####################
### History Files ###
#####################

# Change history directory for less, redis, and sqlite
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export SQLITE_HISTORY="$XDG_CACHE_HOME/sqlite/history"
export REDISCLI_HISTFILE="$XDG_CACHE_HOME/redis/history"

##############
### Python ###
##############

# Cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE="$XDG_CACHE_HOME/pip"

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

#############
### C/C++ ###
#############

############
### Rust ###
############

# Rust-specific settings
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

##########
### Go ###
##########

# Go-specific settings
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$HOME/.local/bin"

#####################
### Miscellaneous ###
#####################

# Preferred editor for local and remote sessions
export EDITOR=vim
export VISUAL=vim

# Path to manpages
export MANPATH="/usr/local/man:$MANPATH"

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL='en_US.UTF-8';

###########################
### System/Library Path ###
###########################

# Save local bin and lib directories
export LOCAL_BIN="$HOME/.local/bin"
export LOCAL_LIB="$HOME/.local/lib"

## Path Manipulation. Allows adding to paths in POSIX shell without duplication.
## See: https://unix.stackexchange.com/a/124447
pathprepend() { case ":${PATH:=$1}:" in *:"$1":*) ;; *) PATH="$1:$PATH" ;; esac; }
pathappend() { case ":${PATH:=$1}:" in *:"$1":*) ;; *) PATH="$PATH:$1" ;; esac; }

# Add LOCAL_BIN to PATH if exists
[ -d "$LOCAL_BIN" ] && pathprepend "$LOCAL_BIN"

# Set lib PATH, and add LOCAL_LIB if it exists
[ -z "$LD_LIBRARY_PATH" ] && export LD_LIBRARY_PATH="/usr/local/lib:/usr/lib"
case ":${LD_LIBRARY_PATH:=$LOCAL_LIB}:" in
    *:"$LOCAL_LIB":*)  ;;
    *) LD_LIBRARY_PATH="$LOCAL_LIB:$LD_LIBRARY_PATH"  ;;
esac

# Guard to prevent sourcing multiple times
_dt_shared_env_loaded=y
