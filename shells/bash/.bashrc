# ~/.bashrc
#
# this file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output. so make sure this doesn't display
# anything or bad things will happen !

# test for an interactive shell. there is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # shell is non-interactive. be done now!
    return
fi

# Source additional sh configs
for config in "${HOME}"/.config/sh/custom/*.sh ; do
    source "${config}"
done

# For easy variable expansion
bash_dir="$XDG_CONFIG_HOME/bash/custom"

# Allow local customizations in the ~/.bashrc_local_before file
[[ -f ~/.bashrc_local_before ]] && source ~/.bashrc_local_before

# External plugins (initialized before general settings)
[[ -f "$bash_dir/plugins_before.bash" ]] && source "$bash_dir/plugins_before.bash"

# General bash settings
[[ -f "$bash_dir/settings.bash" ]] && source "$bash_dir/settings.bash"

# Aliases explicitly for bash
[[ -f "$bash_dir/aliases.bash" ]] && source "$bash_dir/aliases.bash"

# Custom prompt config
[[ -f "$bash_dir/prompt.bash" ]] && source "$bash_dir/prompt.bash"

# Load completion settings
[[ -f "$bash_dir/completions.bash" ]] && source "$bash_dir/completions.bash"

# External plugins (initialized after general settings)
[[ -f "$bash_dir/plugins_after.bash" ]] && source "$bash_dir/plugins_after.bash"

# Allow local customizations in the ~/.bashrc_local_after file
# Note: This is where conda sourcing goes & Display export for WSL
[[ -f ~/.bashrc_local_after ]] && source ~/.bashrc_local_after
