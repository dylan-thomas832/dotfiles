# Track dotfile scripts
export PATH=$HOME/.dotfiles/bin:$HOME/.dotfiles/vscode:$PATH

# Add Anaconda to path
# export PATH=$HOME/anaconda2/bin:$PATH
# export PATH=$HOME/anaconda3/bin:$PATH

# Shared library path
export LD_LIBRARY_PATH=/usr/lib:/usr/local/lib

# Local binaries
export PATH=/usr/local/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

# These should be there already
# /usr/bin:/usr/sbin:

# Path to manpages?
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh keys
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='vim'
fi

