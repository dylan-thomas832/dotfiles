### ZSH Settings/Features that should be set first

# Autoload common modules/functions
autoload -Uz colors && colors
autoload -Uz zcalc

# Test for unicode support, 
#   From: https://github.com/vincentbernat/zshrc/blob/master/rc/00-helpers.zsh
_dt_can_do_unicode () {
    # We need:
    #  1. multibyte input support
    #  2. locale support
    #  3. terminal support
    # Locale support is tested by trying to output an unicode
    # character. zsh will choke with "character not in range" if this
    # doesn't work.
    if [[ -o multibyte ]] && (( ${#${:-$(print -n "\u21B5\u21B5" 2> /dev/null)}} == 2 )); then
        case $TERM in
            screen*|xterm*|rxvt*|alacritty*) return 0 ;;
        esac
    fi
    return 1
}

# Creates a mapping for easy reference to characters. Uses unicode if available.
#   From: https://github.com/vincentbernat/zshrc/blob/master/rc/02-terminfo.zsh
typeset -gA PRCH
if _dt_can_do_unicode; then
    PRCH=(
        sep $'\uE0B1' end $'\uE0B0'
        retb "" reta $' \u2717'
        circle $'\u25CF' branch $'\uE0A0'
        ok $'\u2713' ellipsis $'\u2026'
        eol $'\u23CE' running $'\u21BB'
        python $'\U1f40d'
        docker $'\U1f40b'
        nix $'\u2744\ufe0f '
        elapsed $'\u231b'
        up $'\u25B2' down $'\u25BC'
        prompt $'\u276f'
    )
else
    PRCH=(
        sep "/" end ""
        retb "<" reta ">"
        circle "*" branch "\`|"
        ok ">" ellipsis ".."
        eol "~~" running "> "
        python "python"
        docker "docker"
        nix "nix"
        elapsed ''
        up '^' down 'v'
        prompt '>'
    )
fi

# Initializes prompt to bottom of terminal
# print ${(pl:$LINES::\n:):-}


# Title stuff
autoload -Uz add-zsh-hook

function xterm_title_precmd () {
    print -Pn -- '\e]2;%m %~\a'
    [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
    print -Pn -- '\e]2;%m %~ %# ' && print -n -- "${(q)1}\a"
    [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (alacritty*|gnome*|konsole*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
    add-zsh-hook -Uz precmd xterm_title_precmd
    add-zsh-hook -Uz preexec xterm_title_preexec
fi
