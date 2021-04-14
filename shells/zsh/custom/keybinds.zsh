### Keybindings

## VIM Mode Settings ##
bindkey -v              # vi mode
export KEYTIMEOUT=40    # Helps with jk

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${key[Up]}" ]]; then
    # Makes searching history go to the end of the line
    autoload -Uz history-beginning-search-backward-end history-search-end
    zle -N history-beginning-search-backward-end history-search-end

    bindkey -M viins "${key[Up]}" history-beginning-search-backward-end
    bindkey -M vicmd "${key[Up]}" history-beginning-search-backward-end
fi
# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${key[Down]}" ]]; then
    # Makes searching history go to the end of the line
    autoload -Uz history-beginning-search-forward-end history-search-end
    zle -N history-beginning-search-forward-end history-search-end

    bindkey -M viins "${key[Down]}" history-beginning-search-forward-end
    bindkey -M vicmd "${key[Down]}" history-beginning-search-forward-end
fi

# [Home] - Go to beginning of line
if [[ -n "${key[Home]}" ]]; then
    bindkey -M viins "${key[Home]}" beginning-of-line
    bindkey -M vicmd "${key[Home]}" beginning-of-line
fi
# [End] - Go to end of line
if [[ -n "${key[End]}" ]]; then
    bindkey -M viins "${key[End]}"  end-of-line
    bindkey -M vicmd "${key[End]}"  end-of-line
fi

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${key[Shift-Tab]}" ]]; then
    bindkey -M viins "${key[Shift-Tab]}" reverse-menu-complete
    bindkey -M vicmd "${key[Shift-Tab]}" reverse-menu-complete
fi

# [Backspace] - delete backward
if [[ -n "${key[Backspace]}" ]]; then
    bindkey -M viins "${key[Backspace]}" backward-delete-char
    bindkey -M vicmd "${key[Backspace]}" backward-delete-char
else
    bindkey -M viins '^?' backward-delete-char
    bindkey -M vicmd '^?' backward-delete-char
fi
# [Delete] - delete forward
if [[ -n "${key[Delete]}" ]]; then
    bindkey -M viins "${key[Delete]}" delete-char
    bindkey -M vicmd "${key[Delete]}" delete-char
else
    bindkey -M viins "^[[3~" delete-char
    bindkey -M vicmd "^[[3~" delete-char

    bindkey -M viins "^[3;5~" delete-char
    bindkey -M vicmd "^[3;5~" delete-char
fi

# [Ctrl-Delete] - delete whole forward-word
bindkey -M viins '^[[3;5~' kill-word
bindkey -M vicmd '^[[3;5~' kill-word

# [Ctrl-LeftArrow] - move backward one word
if [[ -n "${key[Control-Left]}" ]]; then
    bindkey -M viins "${key[Control-Left]}" backward-word
    bindkey -M vicmd "${key[Control-Left]}" backward-word
else
    bindkey -M viins '^[[1;5D' backward-word
    bindkey -M vicmd '^[[1;5D' backward-word
fi
# [Ctrl-RightArrow] - move forward one word
if [[ -n "${key[Control-Right]}" ]]; then
    bindkey -M viins "${key[Control-Right]}" forward-word
    bindkey -M vicmd "${key[Control-Right]}" forward-word
else
    bindkey -M viins '^[[1;5C' forward-word
    bindkey -M vicmd '^[[1;5C' forward-word
fi

# Enable incremental search. This must come __after__ "bindkey -v"
# Only enable if fzf isn't installed
if [[ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ]]; then
    autoload -Uz history-incremental-search-backward
    bindkey "^R" history-incremental-search-backward
fi

# Makes CTRL+Z into a toggle switch
ctrlz() {
    if [[ $#BUFFER == 0 ]]; then
        fg >/dev/null 2>&1 && zle redisplay
    else
        zle push-input
    fi
}
zle -N ctrlz
bindkey '^Z' ctrlz

# Use 'jk' to go to command mode
bindkey -M viins 'jk' vi-cmd-mode

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Change cursor & glyph depending on vi mode
zle-line-init zle-keymap-select () {
    # Setup and reset prompt on mode switch
    # [NOTE]: This must be done to properly configure the prompt
    _dt_setup_prompt && zle reset-prompt
    # Switch cursor
    case ${KEYMAP} in
        vicmd)      echo -ne '\e[1 q' ;;
        viins|main) echo -ne '\e[5 q' ;;
    esac
}
zle -N zle-keymap-select
zle -N zle-line-init

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
