### ZSH Plugins loaded before compinit ###
# Author: Dylan Thomas

## ZSH function plugins

# NOTE: I believe it is best practice to source completion plugins before compinit
#   see https://github.com/zsh-users/zsh-completions#manual-installation

# Extra completions
fpath+=$ZDOTDIR/vendor/zsh-completions/src
# Conda completion
fpath+=$ZDOTDIR/vendor/conda-zsh-completion
# Custom completion functions included in dotfiles
fpath+=$ZDOTDIR/zfuncs

## Custom ZSH plugins

# ZSH completion for pip
# Retrieved via: `pip completion --zsh`
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
}
compctl -K _pip_completion python -m pip

# FZF sourcing
[[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ]] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# Force FZF to use ag. -g "" allow ag to search filenames and pipe to fzf
# export FZF_DEFAULT_COMMAND='ag --hidden --path-to-ignore ~/.config/agignore -g ""'

# Force FZF to use fd instead of find
# export FZF_DEFAULT_COMMAND="fdfind --type f --hidden --ignore-file ~/.config/agignore"

# # Copy command to fzf keyboard shortcuts. Set default fzf options.
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--reverse --preview 'cat {}' --color=bg+:#293739,bg:#1B1D1E,border:#808080,spinner:#E6DB74,hl:#7E8E91,fg:#F8F8F2,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#F8F8F2,prompt:#F92672,hl+:#F92672"

