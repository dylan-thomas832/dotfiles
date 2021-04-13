#!/usr/bin/env bash

## This script installs all requirements/dependencies for Alacritty on Ubuntu

# Get Rust installer and run it
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -- --no-modify-path --verbose
rustup override set stable
rustup update stable

# Apt dependencies for Alacritty
sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3

# Clone, build, and install alacritty.
directory = pwd
mkdir -p ~/repos && cd repos
git clone https://github.com/alacritty/alacritty.git && cd alacritty
cargo build --release
cp target/release/alacritty ~/.local/bin/
cd directory
