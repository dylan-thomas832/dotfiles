# Enable incremental search
bindkey "^R" history-incremental-search-backward
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
# Home, End, Delete keys
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
# CTRL + Left/Right
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# Syntax highlighting from zsh-users
source ~/.zshrc.d/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Substring search from zsh-users
source ~/.zshrc.d/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
