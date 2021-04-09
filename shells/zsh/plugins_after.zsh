### ZSH Plugins loaded after compinit ###
# Author: Dylan Thomas


## ZSH Script plugins

# NOTE: Syntax highlighting needs to be sourced after compinit, and before history substring search
#   see https://github.com/zsh-users/zsh-syntax-highlighting#why-must-zsh-syntax-highlightingzsh-be-sourced-at-the-end-of-the-zshrc-file
#   see https://github.com/zsh-users/zsh-history-substring-search#usage

# Syntax highlighting from zsh-users
source ~/.config/zsh/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Substring search from zsh-users
source ~/.config/zsh/vendor/zsh-history-substring-search/zsh-history-substring-search.zsh

# Auto suggestions (pre-typed)
source ~/.config/zsh/vendor/zsh-autosuggestions/zsh-autosuggestions.zsh
# Customize the auto-suggest foreground color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=075'

# Custom ZSH plugins

# For running pfetch if interested
export PF_INFO="ascii title os host kernel de shell uptime pkgs memory palette"
