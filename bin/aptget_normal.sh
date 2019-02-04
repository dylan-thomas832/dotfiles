#!/bin/bash

set -e

# Esnure we have basics
apt-get install git wget curl vim -y

# Python stuff
apt-get install python-dev python-pip python3-dev python3-pip -y

# Get zsh and tmux
apt-get install zsh tmux -y

# Get Ack & Ag
apt-get install ack-grep silversearcher-ag -y

echo "Finished apt-get installs!"

