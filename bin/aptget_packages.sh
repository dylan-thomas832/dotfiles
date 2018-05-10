#!/bin/bash

set -e

# Pretty basic setup
apt-get install build-essential gfortran cmake cmake-curses-gui -y

# Python stuff
apt-get install python-dev python-pip python3-dev python3-pip -y

# BLAS/LAPACK
apt-get install libopenblas-dev libatlas-base-dev liblapack-dev -y

# Esnure we have basics
apt-get install git wget curl vim -y

# Get zsh
apt-get install zsh -y

# Get Ack & Ag
apt-get install ack-grep silversearcher-ag

echo "Finished apt-get installs!"

