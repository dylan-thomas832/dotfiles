# Load VCS plugin
autoload -Uz vcs_info

# Set colors for git staged/unstaged info
zstyle ':vcs_info:git:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{yellow}●%f '
# Auto check for staged/unstaged
zstyle ':vcs_info:git:*' check-for-changes true
# Set format for VCS info msg on regular check
zstyle ':vcs_info:git:*' formats "%F{blue}%b%f %u%c"
# Set format for VCS info msg when doing rebase/merge/cherry pick, etc.
zstyle ':vcs_info:git:*' actionformats "%F{red}%a%f|%F{blue}%b%f %u%c"
# Only enable git
zstyle ':vcs_info:*' enable git

# Called before prompt generated
precmd() {
    # As always first run the system so everything is setup correctly.
    # And then just set PROMPT/PS1, RPROMPT/RPS1 to whatever you want to.
    _setup_ps1
}

# Actually set the prompt variables ('PROMPT' & 'RPROMPT') by calling `vcs_info`
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
