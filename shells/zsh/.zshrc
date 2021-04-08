# Source additional sh configs
for config in "${HOME}"/.config/sh/*.sh ; do
    source "${config}"
done

# Allow local customizations in the ~/.zshrc_local_before file
if [ -f ~/.zshrc_local_before ]; then
    source ~/.zshrc_local_before
fi

# External plugins (initialized before general settings)
source ~/.config/zsh/plugins.zsh

# General ZSH settings
source ~/.config/zsh/settings.zsh

# Aliases explicitly for ZSH
source ~/.config/zsh/aliases.zsh

# Custom prompt config
source ~/.config/zsh/prompt.zsh

# Allow local customizations in the ~/.zshrc_local_after file
# Note: This is where conda sourcing goes & Display export for WSL
if [ -f ~/.zshrc_local_after ]; then
    source ~/.zshrc_local_after
fi
