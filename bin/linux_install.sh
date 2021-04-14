#!/usr/bin/env bash

set -e

# Update/upgrade package
apt update && apt upgrade -y

# Pretty basic setup
apt install -y build-essential gfortran cmake cmake-curses-gui

# Python stuff
apt install -y python3-dev python3-pip python3-tk

# BLAS/LAPACK
apt install -y libopenblas-dev libatlas-base-dev liblapack-dev

# Esnure we have basics
apt install -y git wget curl vim ctags xdg-utils

# Get zsh
apt install -y zsh

# Get Ack, Ag, fd, tree, and ripgrep for niceties!
apt install -y ack-grep silversearcher-ag fd-find tree ripgrep

# Get Rust installer and run it
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path --verbose
rustup override set stable
rustup update stable

# Apt dependencies for Alacritty
sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3

## Cargo installs

# Install Alacritty (fast terminal emulator)
cargo install alacritty

# Install bat (cat, but with color)
cargo install --locked bat

# Install delta (better termina git diff viewer)
cargo install git-delta


# Remove unneeded packages
apt autoremove -y

echo "Finished apt installs!"
