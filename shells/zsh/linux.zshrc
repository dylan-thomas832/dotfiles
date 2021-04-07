# Source additional sh configs
for config in "${HOME}"/.config/sh/*.sh ; do
    source "${config}"
done

# Allow local customizations in the ~/.zshrc_local_before file
if [ -f ~/.zshrc_local_before ]; then
    source ~/.zshrc_local_before
fi

# External plugins (initialized before)
source ~/.config/zsh/plugins_before.zsh

# Load contained custom functions
source ~/.config/zsh/functions.zsh

# Aliases
source ~/.config/zsh/aliases.zsh

# Custom prompt
source ~/.config/zsh/prompt.zsh

# # Syntax highlighting
# source ~/.config/zsh/syntax.zsh

# External plugins (initialized after)
source ~/.config/zsh/plugins_after.zsh

# Allow local customizations in the ~/.zshrc_local_after file
# Note: This is where conda sourcing goes & Display export for WSL
if [ -f ~/.zshrc_local_after ]; then
    source ~/.zshrc_local_after
fi
