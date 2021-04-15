### ZSH Plugins loaded after compinit ###
# Author: Dylan Thomas


## ZSH Script plugins

# NOTE: Syntax highlighting needs to be sourced after compinit, and before history substring search
#   see https://github.com/zsh-users/zsh-syntax-highlighting#why-must-zsh-syntax-highlightingzsh-be-sourced-at-the-end-of-the-zshrc-file
#   see https://github.com/zsh-users/zsh-history-substring-search#usage

# Fast syntax highlighting from https://github.com/zdharma/fast-syntax-highlighting
source ~/.config/zsh/vendor/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
# Original syntax highlighting
# source ~/.config/zsh/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Substring search from zsh-users
source ~/.config/zsh/vendor/zsh-history-substring-search/zsh-history-substring-search.zsh
## [NOTE]: These overwrite the standard ZSH history searches

# Start typing + [Up-Arrow] - Search for sub-string in history backwards
if [[ -n "${key[Up]}" ]]; then
    bindkey -M viins "${key[Up]}" history-substring-search-up
    bindkey -M vicmd "${key[Up]}" history-substring-search-up
fi
# Start typing + [Down-Arrow] - Search for sub-string in history forwards
if [[ -n "${key[Down]}" ]]; then
    bindkey -M viins "${key[Down]}" history-substring-search-down
    bindkey -M vicmd "${key[Down]}" history-substring-search-down
fi
# Turns on fuzzy searching
HISTORY_SUBSTRING_SEARCH_FUZZY=true
# Customize query highlighting when command is found
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=magenta,bold"
# Customize query highlighting when no command is found
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=red"

# Auto suggestions (pre-typed)
source ~/.config/zsh/vendor/zsh-autosuggestions/zsh-autosuggestions.zsh
# Customize the auto-suggest foreground color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=075'
# Use history first, then completion eng for suggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# Fetch suggestions asynchronously
ZSH_AUTOSUGGEST_USE_ASYNC=true
# Disable auto-suggestions for buffers over a certain length
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
# Bind CTRL+<SPACE> to accept suggestion
bindkey '^ ' autosuggest-accept

# Custom ZSH plugins

# For running pfetch if interested
export PF_INFO="ascii title os host kernel de shell uptime pkgs memory palette"

# FZF sourcing
[[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ]] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# Set the default FZF command to use ripgrep, silver-searcher, fd, or find
local 'fzf_command'
if (( $+commands[rg] )) ; then
    # Force FZF to use `rg`
    fzf_command='rg --files --hidden --color=auto --smart-case --follow --ignore-file ~/.config/agignore'
elif (( $+commands[ag] )) ; then
    # Force FZF to use ag. -g "" allow `ag` to search filenames and pipe to fzf
    fzf_command='ag --hidden --path-to-ignore ~/.config/agignore -g ""'
elif (( $+commands[fdfind] )) ; then
    # Force FZF to use `fd` instead of `find`
    fzf_command="fdfind --type f --hidden --ignore-file ~/.config/agignore"
else
    # No search util found, use `find`
    fzf_command="find --type f"
fi
export FZF_DEFAULT_COMMAND=$fzf_command

# Default FZF options here
FZF_DEFAULT_OPTS="--reverse"
# Dracula color scheme from here: https://github.com/junegunn/fzf/wiki/Color-schemes#dracula
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'

# CTRL+T uses default fzf command with toggle-able, colorized file preview
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Set options for CTRL+T. Use `bat` if it exists, otherwise `cat`
local 'fzf_ctrl_t_opts'
if (( $+commands[bat] )) ; then
    fzf_ctrl_t_opts="--reverse --preview 'bat --style=numbers --color=always --theme=Dracula --line-range :500 {}' --bind '?:toggle-preview'"
else
    fzf_ctrl_t_opts="--reverse --preview 'cat {}' --bind '?:toggle-preview'"
fi
export FZF_CTRL_T_OPTS=$fzf_ctrl_t_opts

# CTRL+R uses echo for toggle-able command preview under
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# ALT+C uses fd with toggle-able directory tree preview
local 'fzf_alt_c_command'
# Use `fd` if available, otherwise default to `find`
if (( $+commands[fdfind] )) ; then
    fzf_alt_c_command="fdfind -t d"
else
    fzf_alt_c_command="find -type d "
fi
export FZF_ALT_C_COMMAND=$fzf_alt_c_command

# If `tree` is available, enable tree-view preview panel for ALT+C
if (( $+commands[tree] )) ; then
    export FZF_ALT_C_OPTS="--reverse --preview 'tree -adC {} | head -200' --bind '?:toggle-preview'"
fi

# Use bat as the manpager, if it's available
if (( $+commands[bat] )) ; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
else

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
