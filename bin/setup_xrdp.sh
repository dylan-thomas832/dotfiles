#!/usr/bin/env bash

## This script installs all requirements/dependencies for xrdp on Ubuntu WSL

sudo apt install xrdp
sudo cp /etc/xrdp/xrdp.ini /etc/xrdp/xrdp.ini.bak
sudo cp /etc/xrdp/sesman.ini /etc/xrdp/sesman.ini.bak
sudo ln -s /dev/null ~/.xsession-errors
sudo cp 