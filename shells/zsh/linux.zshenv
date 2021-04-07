source "${HOME}/.config/sh/environment.sh"

# Set environment variables here.

# Set the ZSH directory
# [[ -d "${XDG_CONFIG_HOME}/zsh" ]] && export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# Set the ZSH cache directory
[[ -d "${XDG_CACHE_HOME}/zsh" ]] && export ZCACHEDIR="${XDG_CACHE_HOME}/zsh"

# For running pfetch if interested
export PF_INFO="ascii title os host kernel de shell uptime pkgs memory palette"
