#!/usr/bin/env bash

set -e

# Update/upgrade package
apt update
apt upgrade -y

# Pretty basic setup
apt install -y build-essential gfortran cmake cmake-curses-gui

# Python stuff
apt install -y python3-dev python3-pip python3-tk

# BLAS/LAPACK
apt install -y libopenblas-dev libatlas-base-dev liblapack-dev

# Esnure we have basics
apt install -y git wget curl vim ctags

# Get zsh
apt install -y zsh

# Get Ack & Ag
apt install -y ack-grep silversearcher-ag

# Remove unneeded packages
apt autoremove -y

echo "Finished apt installs!"