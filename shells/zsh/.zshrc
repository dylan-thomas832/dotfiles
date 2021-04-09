# Run for interactive shells only

# Source additional sh configs
for config in "${HOME}"/.config/sh/*.sh ; do
    source "${config}"
done

# Allow local customizations in the ~/.zshrc_local_before file
[[ -f ~/.zshrc_local_before ]] && source ~/.zshrc_local_before

# External plugins (initialized before general settings)
[[ -f ~/"${ZDOTDIR}"/plugins.zsh ]] && source ~/"${ZDOTDIR}"/plugins.zsh

# General ZSH settings
[[ -f ~/"${ZDOTDIR}"/settings.zsh ]] && source ~/"${ZDOTDIR}"/settings.zsh

# Aliases explicitly for ZSH
[[ -f ~/"${ZDOTDIR}"/aliases.zsh ]] && source ~/"${ZDOTDIR}"/aliases.zsh

# Custom prompt config
[[ -f ~/"${ZDOTDIR}"/prompt.zsh ]] && source ~/"${ZDOTDIR}"/prompt.zsh

# Allow local customizations in the ~/.zshrc_local_after file
# Note: This is where conda sourcing goes & Display export for WSL
[[ -f ~/.zshrc_local_after ] source ~/.zshrc_local_after
