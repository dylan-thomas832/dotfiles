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

# FZF sourcing
[[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ]] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# Force FZF to use rg
export FZF_DEFAULT_COMMAND='rg --files --hidden --color=auto --follow --ignore-file ~/.config/agignore'

# Force FZF to use ag. -g "" allow ag to search filenames and pipe to fzf
# export FZF_DEFAULT_COMMAND='ag --hidden --path-to-ignore ~/.config/agignore -g ""'

# Force FZF to use fd instead of find
# export FZF_DEFAULT_COMMAND="fdfind --type f --hidden --ignore-file ~/.config/agignore"

# Default FZF options
export FZF_DEFAULT_OPTS="--reverse --color=bg+:#293739,bg:#1B1D1E,border:#808080,spinner:#E6DB74,hl:#7E8E91,fg:#F8F8F2,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#F8F8F2,prompt:#F92672,hl+:#F92672"

# CTRL+T uses default fzf command with toggle-able, colorized file preview
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--reverse --preview 'bat --style=numbers --color=always --line-range :500 {}' --bind '?:toggle-preview'"

# CTRL+R uses echo for toggle-able command preview under
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# ALT+C uses fd with toggle-able directory tree preview
export FZF_ALT_C_COMMAND="fdfind -t d . "
export FZF_ALT_C_OPTS="--reverse --preview 'tree -adC {} | head -200' --bind '?:toggle-preview'"
