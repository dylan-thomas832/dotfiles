#!/usr/bin/env bash

## This script installs all requirements/dependencies for Qtile on Ubuntu
## This should prep for a complete window manager installation

# Install apt dependencies
sudo apt install libxcb-render0-dev libffi-dev libcairo2 libpangocairo-1.0-0

# Install Xcffib. Recommended to install first by itself
/usr/bin/pip3 install --no-cache-dir xcffib

# Install pip dependencies
/usr/bin/pip3 install --no-cache-dir cairocffi dbus-next

# Install Qtile
/usr/bin/pip3 install qtile

# Install Qtile widget dependencies
/usr/bin/pip3 install psutil pyxdg

# Install other tools for Qtile to work with
sudo apt install nitrogen dunst rofi
