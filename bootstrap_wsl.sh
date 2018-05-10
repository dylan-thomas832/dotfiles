#!/bin/bash
#
# Simple install script for setting up terminal/shell in WSL
#
# Author: Dylan Thomas

## Intro{{{

set -e

# Basic install script for a wsl instance

echo " "
echo "Custom install script. See 'wsl_install.out' for details."
echo " "

# Save output file
OUTFILE="setup_log.out"

#}}}


## Update Repo {{{

# Update git
echo "Updating repository and submodules."
git pull origin master
git submodule update --init --recursive
#}}}


## Creating directories {{{

# Make necessary $HOME dirs
echo "Making directories."
mkdir -p ~/docs
mkdir -p ~/libraries
mkdir -p ~/git_ext
mkdir -p ~/projects
mkdir -p ~/tars
mkdir -p ~/temp
mkdir -p ~/.vim/files/info
mkdir -p ~/.vim/files/undo
mkdir -p ~/.vim/files/swap
mkdir -p ~/.vim/files/backup
mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/colors
mkdir -p ~/.vim/bundle
#}}}


## Install packages {{{

# Call package install scripts
echo "Starting package updates."
sudo ./bin/new_install_update.sh > $OUTFILE
echo "Starting package installs."
sudo ./bin/get_packages.sh > $OUTFILE
echo "Starting python setup."
./bin/get_python_packages.sh > $OUTFILE

#}}}

## Zsh & Terminal {{{
echo "Setting up terminal and zsh."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

cd ./fonts
./install.sh
cd ..
echo "WSL must download the font from: https://github.com/powerline/fonts/tree/master/DejaVuSansMono, open, and install!"
#}}}

## VIM setup {{{
echo "Starting VIM setup."

# Get color themes
cp ./badwolf/colors/badwolf.vim ~/.vim/colors/
cp ./molokai/colors/molokai.vim ~/.vim/colors/
cp ./vim-colors-solarized/colors/solarized.vim ~/.vim/colors/

# Get pathogen
cp ./vim-pathogen/autoload/pathogen.vim ~/.vim/autoload/

# Get Ack via pathogen
git clone https://github.com/mileszs/ack.vim.git ~/.vim/bundle/ack.vim


#}}}

## Symbolic linking {{{
echo "Linking files."

# vim
ln -svf ./.vimrc ~/.vimrc
#ln -svf ./.vim/ ~/.vim/

# zsh
ln -svf ./.zshrc ~/.zshrc

# bash
ln -svf ./.bashrc ~/.bashrc

# git
ln -svf ./.gitconfig ~/.gitconfig
ln -svf ./.gitignore ~/.gitignore

# bin directory
ln -svf ./bin/ ~/bin/

#}}}


