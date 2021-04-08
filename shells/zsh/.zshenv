source "${HOME}/.config/sh/environment.sh"

# Skip over global `compinit` call, since we do it anyways
skip_global_compinit=1

# Set environment variables here.

# Force set shell
export SHELL=$(which zsh)

# Set the ZSH cache directory
[[ -d "${XDG_CACHE_HOME}/zsh" ]] && export ZCACHEDIR="${XDG_CACHE_HOME}/zsh"

# For running pfetch if interested
export PF_INFO="ascii title os host kernel de shell uptime pkgs memory palette"
