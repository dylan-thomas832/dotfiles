####################################
#### ZSH Git Prompt Integration ####
####################################
# Author: Dylan Thomas

# Custom asynchronous git prompt using forks. Assumes git information in the
#   right prompt, but you could modify this for anywhere

# [TODO]: scoped?
# [TODO]: Only do 'command true' for older zsh versions
# [TODO]: Add up/down arrow for ahead/behind remote?

_dt_vcs_async() {
    typeset -g VCS_ASYNC_FD=
    # Fork process to call VCS and update 'vcs_info_msg_0_'
    exec {VCS_ASYNC_FD}< <(
        vcs_info
        # sleep 0.2
        echo -nE ${vcs_info_msg_0_}
    )

    # There's a weird bug here where ^C stops working unless we force a fork
    # See https://github.com/zsh-users/zsh-autosuggestions/issues/364
    # Only required for ZSH_VERSION<5.7.1
    command true

    # When the fd is readable, call the response handler
    zle -F "$VCS_ASYNC_FD" _dt_vcs_async::set
}

# Called when new data is ready to be read from the pipe
# First arg will be fd ready for reading
# Second arg will be passed in case of error
_dt_vcs_async::set() {
    emulate -L zsh

    # Check for error
    if [[ -z "$2" || "$2" == "hup" ]]; then
        # Read everything from fd, and put into RPROMPT
        read -r -u "$VCS_ASYNC_FD" RPROMPT

        # Only force prompt reset if not empty
        [[ -n $RPROMPT ]] && zle reset-prompt

        # Close th fd
        exec {1}<&-
    fi

    # Always remove the handler
    zle -F "$1"
}

# Encapsulate in check for root user; Don't do git stuff if root.
[[ $USERNAME != "root" ]] && {

    ########################
    ### Git Prompt Style ###
    ########################

    # Only enable git
    zstyle ':vcs_info:*' enable git
    # Anonymous function that is called immediately; Allows scoping variables.
    () {
        # Define formats here
        local format='%F{blue}${PRCH[branch]} %B%b%%b%f %u%c'
        local action_format='%F{blue}${PRCH[branch]} %B%b%F{white}|%%b%F{red}%a%f %u%c'
        # Auto check for staged/unstaged
        zstyle ':vcs_info:git:*' check-for-changes true
        # Set format for VCS info msg on regular check
        zstyle ':vcs_info:git:*' formats $format
        # Set format for VCS info msg when doing rebase/merge/cherry pick, etc.
        zstyle ':vcs_info:git:*' actionformats $action_format
        # Set color & symbol for git staged/unstaged info
        zstyle ':vcs_info:git:*' stagedstr '%F{green}${PRCH[circle]}%f'
        zstyle ':vcs_info:git:*' unstagedstr '%F{yellow}${PRCH[circle]}%f'
    }

    # Custom git hook to check for untracked files. Adds a black circle.
    zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
    +vi-git-untracked () {
        if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
            git status --porcelain 2> /dev/null | grep -q '??' ; then
            hook_com[staged]+='%F{240}${PRCH[circle]}%f'
        fi
    }

}
