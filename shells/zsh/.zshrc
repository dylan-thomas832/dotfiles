# Run for interactive shells only

# Source additional sh configs
for config in "${HOME}"/.config/sh/custom/*.sh ; do
    source "${config}"
done

# Keep sourcing in local scope. Prevents variables from cluttering shell environment
() {
    local zsh_dir="$ZDOTDIR/custom"

    # Allow local customizations in the ~/.zshrc_local_before file
    [[ -f ~/.zshrc_local_before ]] && source ~/.zshrc_local_before

    # External plugins (initialized before general settings)
    [[ -f $zsh_dir/init.zsh ]] && source $zsh_dir/init.zsh

    # External plugins (initialized before general settings)
    [[ -f $zsh_dir/plugins_before.zsh ]] && source $zsh_dir/plugins_before.zsh

    # General ZSH settings
    [[ -f $zsh_dir/settings.zsh ]] && source $zsh_dir/settings.zsh

    # Aliases explicitly for ZSH
    [[ -f $zsh_dir/aliases.zsh ]] && source $zsh_dir/aliases.zsh

    # Custom prompt config
    [[ -f $zsh_dir/vcs.zsh ]] && source $zsh_dir/vcs.zsh

    # Custom prompt config
    [[ -f $zsh_dir/prompt.zsh ]] && source $zsh_dir/prompt.zsh

    # Load completion settings
    [[ -f $zsh_dir/completions.zsh ]] && source $zsh_dir/completions.zsh

    # Load keybindings
    [[ -f $zsh_dir/keybinds.zsh ]] && source $zsh_dir/keybinds.zsh

    # External plugins (initialized after general settings)
    [[ -f $zsh_dir/plugins_after.zsh ]] && source $zsh_dir/plugins_after.zsh

    # Allow local customizations in the ~/.zshrc_local_after file
    # Note: This is where conda sourcing goes & Display export for WSL
    [[ -f ~/.zshrc_local_after ]] && source ~/.zshrc_local_after
}

# automatically remove duplicates from these arrays
typeset -U manpath
