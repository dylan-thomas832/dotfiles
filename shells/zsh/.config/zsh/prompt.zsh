# Load VCS plugin
autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{green}●%f '
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●%f '
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%F{blue}%b%f %u%c"

precmd() {
    # As always first run the system so everything is setup correctly.
    # And then just set PS1, RPS1 and whatever you want to. This $PS1
    # is (as with the other examples above too) just an example of a very
    # basic single-line prompt. See "man zshmisc" for details on how to
    # make this less readable. :-)
    _setup_ps1
}

_setup_ps1() {
  vcs_info
  GLYPH="▲"
  CONDA_CURR_ENV=$(basename "$CONDA_DEFAULT_ENV")
  [ "x$KEYMAP" = "xvicmd" ] && GLYPH="▼"
  PS1="$CONDA_CURR_ENV %(?.%F{blue}.%F{red})$GLYPH%f %(1j.%F{cyan}[%j]%f .)%F{blue}%~%f %(!.%F{red}#%f .)"
  RPROMPT="$vcs_info_msg_0_"
}
_setup_ps1
