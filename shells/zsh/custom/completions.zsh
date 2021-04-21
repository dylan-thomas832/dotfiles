#############################
#### ZSH Completion File ####
#############################
# Author: Dylan Thomas

# Define all completion-specific settings/functions here, then initialize the
#   completion system.

###########################
### Completion Settings ###
###########################

# Add completer styles
zstyle ':completion:*' completer _complete _correct _approximate

# Allows dircolors to be used in completion menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Use menu completion highlighting
zstyle ':completion:*' menu select

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZCACHEDIR

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'
# ... unless we really want to.
zstyle '*' single-ignored show

# Allow partial completion of paths
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

# Prevent CVS files/directories from being completed
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'

# Load completion list
zmodload -i zsh/complist

################################
### ZSH Completion Functions ###
################################
# [NOTE]: I believe it is best practice to source completion plugins before compinit
#   See https://github.com/zsh-users/zsh-completions#manual-installation

# Extra completions
[[ -d $ZVENDORDIR/zsh-completions ]] && fpath+=$ZVENDORDIR/zsh-completions
# Conda completion
[[ -d $ZVENDORDIR/conda-zsh-completion ]] && fpath+=$ZVENDORDIR/conda-zsh-completion
# Custom completion functions included in dotfiles
[[ -d $ZDOTDIR/zfuncs ]] && fpath+=$ZDOTDIR/zfuncs

##############################
### Initialize Completions ###
##############################

# Load, and call compinit. Cache zcompdump file in $ZCACHEDIR
autoload -Uz compinit
compinit -C -d "${ZCACHEDIR}/zcompdump-${HOST/.*/}-${ZSH_VERSION}"
_comp_options+=(globdots)  # Include hidden files.

# Automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit
