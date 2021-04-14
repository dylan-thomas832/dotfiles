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
export FZF_DEFAULT_COMMAND='rg --files --hidden --color=auto --smart-case --follow --ignore-file ~/.config/agignore'

# Force FZF to use ag. -g "" allow ag to search filenames and pipe to fzf
# export FZF_DEFAULT_COMMAND='ag --hidden --path-to-ignore ~/.config/agignore -g ""'

# Force FZF to use fd instead of find
# export FZF_DEFAULT_COMMAND="fdfind --type f --hidden --ignore-file ~/.config/agignore"

# Default FZF options
FZF_DEFAULT_OPTS="--reverse"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'

# CTRL+T uses default fzf command with toggle-able, colorized file preview
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--reverse --preview 'bat --style=numbers --color=always --theme=Dracula --line-range :500 {}' --bind '?:toggle-preview'"

# CTRL+R uses echo for toggle-able command preview under
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# ALT+C uses fd with toggle-able directory tree preview
export FZF_ALT_C_COMMAND="fdfind -t d . "
export FZF_ALT_C_OPTS="--reverse --preview 'tree -adC {} | head -200' --bind '?:toggle-preview'"

# Use bat as the manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Conda setup

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup=$("$HOME/miniconda3/bin/conda" 'shell.bash' 'hook' 2> /dev/null)
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
