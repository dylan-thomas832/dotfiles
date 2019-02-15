# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh

# Make sure to use double quotes to prevent shell expansion
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "trapd00r/zsh-syntax-highlighting-filetypes"
zplug "zdharma/history-search-multi-word"
zplug "chrissicool/zsh-256color"
zplug "ael-code/zsh-colored-man-pages"
zplug "mdumitru/git-aliases"
zplug "supercrabtree/k"
zplug "voronkovich/project.plugin.zsh"
zplug "eendroroy/zed-zsh"
zplug "denysdovhan/spaceship-prompt, use:spaceship.zsh, from:github, as:theme"
zplug "laurenkt/zsh-vimto"
# Other prompt theme
# zplug mafredri/zsh-async, from:github
# zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

# load plugins
zplug load
