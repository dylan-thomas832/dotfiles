#!/usr/bin/env bash

## This script installs all requirements/dependencies for xrdp on Ubuntu WSL

# Install xrdp package
sudo apt install -y xrdp

# Back up default config files
sudo cp /etc/xrdp/xrdp.ini /etc/xrdp/xrdp.ini.bak
sudo cp /etc/xrdp/sesman.ini /etc/xrdp/sesman.ini.bak

# Direct error output because it blows up quickly
sudo ln -s /dev/null ~/.xsession-errors

# Start xrdp service
sudo service xrdp start
