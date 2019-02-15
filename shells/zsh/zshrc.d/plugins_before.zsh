# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh

# Make sure to use double quotes to prevent shell expansion
zplug "zsh-users/zsh-syntax-highlighting"
zplug "trapd00r/zsh-syntax-highlighting-filetypes"
zplug "zdharma/history-search-multi-word"
zplug "chrissicool/zsh-256color"
zplug "ael-code/zsh-colored-man-pages"
# zplug "joel-porquet/zsh-dircolors-solarized"
zplug "zpm-zsh/dircolors-material"
zplug "mdumitru/git-aliases"
zplug "supercrabtree/k"
zplug "zpm-zsh/ls"
zplug "voronkovich/project.plugin.zsh"
zplug "eendroroy/zed-zsh"
zplug "zplug denysdovhan/spaceship-prompt, use:spaceship.zsh, from:github, as:theme"

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