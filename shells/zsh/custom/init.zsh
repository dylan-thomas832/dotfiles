###########################
#### ZSH Initial Setup ####
###########################
# Author: Dylan Thomas

# Place any settings that should be gauranteed to be done first here.

###########################################
### Common Autoloaded Functions/Modules ###
###########################################

# These are modules that multiple ZSH config files depend on being loaded, so
#   it is done in a common place.

# add-zsh-hook:         hook into ZSH Special Functions, called at specific times
# add-zle-hook-widget:  see above, but for ZLE Special Widgets
# colors:               map color names to assoc. arrays for easy referencing
# vcs_info:             load vcs integration for git prompt
# zcalc:                interactive command line calculator
autoload -Uz add-zsh-hook
autoload -Uz add-zle-hook-widget
autoload -Uz colors && colors
autoload -Uz vcs_info
autoload -Uz zcalc

#########################
### Utility Functions ###
#########################

# Test for unicode support.
#   See https://github.com/vincentbernat/zshrc/blob/master/rc/00-helpers.zsh
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

############################
### Prompt Character Set ###
############################

# Creates a mapping for easy reference to characters. Uses unicode if available.
#   See https://github.com/vincentbernat/zshrc/blob/master/rc/02-terminfo.zsh
typeset -gA PRCH
if _dt_can_do_unicode; then
    PRCH=(
        sep $'\uE0B1' end $'\uE0B0'
        retb "" reta $'\u2717'
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
        retb "" reta "x"
        circle "*" branch ""
        ok "+" ellipsis ".."
        eol "~~" running "> "
        python "python"
        docker "docker"
        nix "nix"
        elapsed ''
        up '^' down 'v'
        prompt '>'
    )
fi

######################
### Terminal Title ###
######################

# Write hostname and CWD to to title. Called before prompt is drawn.
function _dt_xterm_title_precmd () {
    print -Pn -- '\e]2;%m %~\a'
    # Specific setting for "screen" terminal
    [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

# Write hostname, CWD, & command to to title. Called after a command is accepted.
function _dt_xterm_title_preexec () {
    print -Pn -- '\e]2;%m %~ %# ' && print -n -- "${(q)1}\a"
    # Specific setting for "screen" terminal
    [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (alacritty*|gnome*|konsole*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
    # Hook title functions into precmd and prexec
    add-zsh-hook -Uz precmd _dt_xterm_title_precmd
    add-zsh-hook -Uz preexec _dt_xterm_title_preexec

    # Shift RPROMPT to right edge of terminal
    # [NOTE]: Put here because this might do weird things in non-VTEs
    export ZLE_RPROMPT_INDENT=0
fi
