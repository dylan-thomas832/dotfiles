### Bash plugins loaded after all other configs

# For running pfetch if interested
export PF_INFO="ascii title os host kernel de shell uptime pkgs memory palette"

# Source fzf
[[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ]] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash

# Force FZF to use rg
export FZF_DEFAULT_COMMAND='rg --files --hidden --color=auto --smart-case --follow --ignore-file ~/.config/agignore'

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

# Source Rust build/compiler stuff
[ -f "$CARGO_HOME/env" ] && . "$CARGO_HOME/env"
