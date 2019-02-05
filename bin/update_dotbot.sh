#!/bin/bash

set -e

# Update dotbot
git submodule update --remote dotbot

# Copy install file to dotfiles main directory
cp dotbot/tools/git-submodule/install ./dotfile_install
