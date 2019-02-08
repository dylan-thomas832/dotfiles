#!/bin/bash

set -e

# Update/upgrade package
apt-get update
apt-get upgrade -y

# Pretty basic setup
apt-get install build-essential gfortran cmake cmake-curses-gui -y

# Python stuff
apt-get install python3-dev python3-pip python3-tk -y

# BLAS/LAPACK
apt-get install libopenblas-dev libatlas-base-dev liblapack-dev -y

# Esnure we have basics
apt-get install git wget curl vim ctags -y

# Get zsh
apt-get install zsh tmux -y

# Get Ack & Ag
apt-get install ack-grep silversearcher-ag -y

# Setup oh-my-zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

echo "Finished apt-get installs!"

