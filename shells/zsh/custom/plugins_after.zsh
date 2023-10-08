#####################
#### ZSH Plugins ####
#####################
# Author: Dylan Thomas
# [NOTE]: Loaded after other non-local zsh config files.

# Most plugins are scoped to only load if they exist.

#######################
### ZSH Git Plugins ###
#######################
# [NOTE]: Syntax highlighting needs to be sourced after compinit, and before history substring search
#   See https://github.com/zsh-users/zsh-syntax-highlighting#why-must-zsh-syntax-highlightingzsh-be-sourced-at-the-end-of-the-zshrc-file
#   See https://github.com/zsh-users/zsh-history-substring-search#usage

# Fast syntax highlighting
[[ -d $ZVENDORDIR/fast-syntax-highlighting ]] && {
    source $ZVENDORDIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
}
# Original syntax highlighting: https://github.com/zsh-users/zsh-syntax-highlighting

# Substring fuzzy history search
# [NOTE]: These overwrite the standard ZSH history searches
[[ -d $ZVENDORDIR/zsh-history-substring-search ]] && {
    source $ZVENDORDIR/zsh-history-substring-search/zsh-history-substring-search.zsh

    # Start typing + [Up-Arrow] - Search for sub-string in history backwards
    bindkey -M viins "^[[A" history-substring-search-up
    bindkey -M vicmd "^[[A" history-substring-search-up
    if [[ -n "${key[Up]}" ]]; then
        bindkey -M viins "${key[Up]}" history-substring-search-up
        bindkey -M vicmd "${key[Up]}" history-substring-search-up
    fi
    # Start typing + [Down-Arrow] - Search for sub-string in history forwards
    bindkey -M viins "^[[B" history-substring-search-down
    bindkey -M vicmd "^[[B" history-substring-search-down
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
}

# Auto suggestions (pre-typed)
[[ -d $ZVENDORDIR/zsh-autosuggestions ]] && {
    source $ZVENDORDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
    # Customize the auto-suggest foreground color
    # [NOTE]: This is removed because the suggestions aren't cleared on accepted prompt
    #       if the color is changed
    # ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=075'
    # Use history first, then completion eng for suggestions
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    # Fetch suggestions asynchronously
    ZSH_AUTOSUGGEST_USE_ASYNC=true
    # Disable auto-suggestions for buffers over a certain length
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
    # Bind CTRL+<SPACE> to accept suggestion
    bindkey '^ ' autosuggest-accept
}

#######################
### FZF Integration ###
#######################

[[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ]] && {
    source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

    # Set the default FZF command to use ripgrep, silver-searcher, fd, or find
    local fzf_rg='rg --files --hidden --color=auto --smart-case --follow --ignore-file ~/.config/agignore'
    local fzf_ag='ag --hidden --path-to-ignore ~/.config/agignore -g ""'
    local fzf_fd="fdfind --type f --hidden --ignore-file ~/.config/agignore"
    local fzf_find="find --type f"

    if (( $+commands[rg] )) ; then
        # Force FZF to use `rg`
        export FZF_DEFAULT_COMMAND=$fzf_rg
    elif (( $+commands[ag] )) ; then
        # Force FZF to use ag. -g "" allow `ag` to search filenames and pipe to fzf
        export FZF_DEFAULT_COMMAND=$fzf_ag
    elif (( $+commands[fdfind] )) ; then
        # Force FZF to use `fd` instead of `find`
        export FZF_DEFAULT_COMMAND=$fzf_fd
    else
        # No search util found, use `find`
        export FZF_DEFAULT_COMMAND=$fzf_find
    fi

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

    # Set options for CTRL+T.
    local fzf_ctrl_t_bat="--reverse --preview 'bat --style=numbers --color=always --theme=Dracula --line-range :500 {}' --bind '?:toggle-preview'"
    local fzf_ctrl_t_cat="--reverse --preview 'cat {}' --bind '?:toggle-preview'"

    # Use `bat` if it exists, otherwise `cat`
    if (( $+commands[bat] )) ; then
        export FZF_CTRL_T_OPTS=$fzf_ctrl_t_bat
    else
        export FZF_CTRL_T_OPTS=$fzf_ctrl_t_cat
    fi

    # CTRL+R uses echo for toggle-able command preview under
    export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

    # ALT+C uses fd with toggle-able directory tree preview
    local fzf_alt_c_fd="fdfind -t d"
    local fzf_alt_c_find="find -type d"

    # Use `fd` if available, otherwise default to `find`
    (( $+commands[fdfind] )) && {
        export FZF_ALT_C_COMMAND=$fzf_alt_c_fd
    } || {
        export FZF_ALT_C_COMMAND=$fzf_alt_c_find
    }

    # If `tree` is available, enable tree-view preview panel for ALT+C
    local fzf_alt_c_opts_tree="--reverse --preview 'tree -adC {} | head -200' --bind '?:toggle-preview'"
    (( $+commands[tree] )) && export FZF_ALT_C_OPTS=$fzf_alt_c_opts_tree

    # Use bat as the manpager, if it's available
    (( $+commands[bat] )) && export MANPAGER="sh -c 'col -bx | bat -l man -p'"
}

##########################
### Custom ZSH Plugins ###
##########################

# For running pfetch if interested
[[ -x pfetch ]] && {
    export PF_INFO="ascii title os host kernel de shell uptime pkgs memory palette"
}

# rust/cargo stuff
if [ -f "$CARGO_HOME/env" ] ; then
    source "$CARGO_HOME/env"
fi

# pyenv setup
if [ -d "$HOME/.pyenv" ] ; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# pipx
if (( $+commands[pipx] )) ; then
    eval "$(register-python-argcomplete pipx)"
fi
