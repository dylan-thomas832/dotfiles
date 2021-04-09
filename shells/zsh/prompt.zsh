# Load VCS plugin
autoload -Uz vcs_info

# Set colors for git info
zstyle ':vcs_info:*' stagedstr '%F{green}●%f '
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●%f '
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%F{blue}%b%f %u%c"

# Called before command
precmd() {
    # As always first run the system so everything is setup correctly.
    # And then just set PS1, RPS1 and whatever you want to. This $PS1
    # is (as with the other examples above too) just an example of a very
    # basic single-line prompt. See "man zshmisc" for details on how to
    # make this less readable. :-)
    _setup_ps1
}

# Actually set the prompt variables ('PS1' & 'RPROMPT') by calling `vcs_info`
# which inserts info into `vcs_info_msg_0`
# This also includes a conda prefix for the current environment
_setup_ps1() {
  vcs_info
  GLYPH="▲"
  # Grabs last bit of path in $CONDA_DEFAULT_ENV. This is updated when `conda activate` is called
  CONDA_CURR_ENV=$(basename "$CONDA_DEFAULT_ENV")
  # Flips the glyph if in vi command mode
  [ "x$KEYMAP" = "xvicmd" ] && GLYPH="▼"
  # Sets the glyph direction for vi-mode and color for the previous command exit code
  # Add `"%? "` in between `}` and `)` to print the exit code directly
  local glyph="%(?.%F{blue}.%F{red})$GLYPH%f"
  # Sets the symbol used for user prompt
  local prompt_symbol="%(!.%F{red}#%f .)"
  # Includes the hostname if logged in using SSH
  local ssh_hostname="%m "
  [[ -z "${SSH_CONNECTION}" ]] && ssh_hostname=""
  # Includes the number of background jobs currently running if > 0
  local background_jobs="%(1j.%F{cyan}[%j]%f .)"
  # Includes the cwd and 3 trailing components.
  # If the current working directory starts with $HOME, that part is replaced by a ‘~’
  local cwd=%F{blue}%3~%f
  PROMPT="$CONDA_CURR_ENV $glyph $ssh_hostname$background_jobs$cwd $prompt_symbol"
  RPROMPT="$vcs_info_msg_0_"
}
_setup_ps1
