#!/bin/bash

if grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null ; then
  echo "Need to download font file from: https://github.com/powerline/fonts, open, and install it."
else
  echo "Installing fonts."
  ~/.dotfiles/terminal/fonts/install.sh
fi
