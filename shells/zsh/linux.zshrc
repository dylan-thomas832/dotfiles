# Allow local customizations in the ~/.zshrc_local_before file
if [ -f ~/.zshrc_local_before ]; then
    source ~/.zshrc_local_before
fi

# External plugins (initialized before)
source ~/.zshrc.d/plugins_before.zsh

# Load contained custom functions
source ~/.zshrc.d/functions.zsh

# Set environment variables
source ~/.zshrc.d/environment.zsh

# Aliases
source ~/.zshrc.d/aliases.zsh

# Custom prompt
source ~/.zshrc.d/prompt.zsh

# # Syntax highlighting
# source ~/.zshrc.d/syntax.zsh

# External plugins (initialized after)
source ~/.zshrc.d/plugins_after.zsh

# Allow local customizations in the ~/.zshrc_local_after file
# Note: This is where conda sourcing goes & Display export for WSL
if [ -f ~/.zshrc_local_after ]; then
    source ~/.zshrc_local_after
fi
