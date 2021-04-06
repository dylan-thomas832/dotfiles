_sh=$(basename $SHELL)

# Add ~/.local/bin to PATH if exists
if [ -d ~/.local/bin ] ; then
    PATH=~/.local/bin:${PATH}
fi

# Add /usr/local/bin to PATH if exists
if [ -d /usr/local/bin ] ; then
    PATH=/usr/local/bin:${PATH}
fi

# Add /usr/bin to PATH if exists
if [ -d /usr/bin ] ; then
    PATH=/usr/bin:${PATH}
fi

# Add ~/.local/lib to PATH if exists
if [ -d ~/.local/lib ] ; then
    LD_LIBRARY_PATH=~/.local/lib:${LD_LIBRARY_PATH}
fi

# Add /usr/local/lib to PATH if exists
if [ -d /usr/local/lib ] ; then
    LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}
fi

# Add /usr/lib to PATH if exists
if [ -d /usr/lib ] ; then
    LD_LIBRARY_PATH=/usr/lib:${LD_LIBRARY_PATH}
fi

# Enable fzf key bindings and completions
if [ -x /usr/bin/fzf ] ; then
    [ -f /usr/share/fzf/key-bindings.${_sh} ] && source /usr/share/fzf/key-bindings.${_sh}
    [ -f /usr/share/fzf/completion.${_sh} ] && source /usr/share/fzf/completion.${_sh}
fi
