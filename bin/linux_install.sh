#!/usr/bin/env bash
###################################
#### Main Linux Install Script ####
###################################
# Author: Dylan Thomas
# [NOTE]: This file is meant to be run with 'bash'

# Main installer script for getting all packages/programs on a generic
#   Ubuntu/Debian machine. "sudo" access is required to install 'apt'
#   packages, but nothing else.

#############
### Setup ###
#############

set -e

# Print nice breaks for different portions of script
install_log() {
    padlength=
    pad=$(printf '%*s' "${#1}")
    pad=${pad// /#}
    echo -e "\n\t$pad"
    echo -e "\t$1"
    echo -e "\t$pad\n"
}

######################
### 'apt' Packages ###
######################

# Update & upgrade
install_log "Updating & upgrading packages."
sudo apt update && sudo apt upgrade -y

# Explanation of apt packages:
#   1) Mostly C/C++/Fortran essentials
#   2) Ensure update-to-date python & pip
#   3) BLAS/LAPACK linear algebra libraries
#   4) Useful dev tools
#   5) Nice upgrades to standard search tools
#   6) Extra requirements for alacritty terminal
install_log "Installing apt packages."
sudo apt install -y \
    build-essential gfortran cmake cmake-curses-gui \
    python3-dev python3-pip python3-tk \
    libopenblas-dev libatlas-base-dev liblapack-dev \
    git wget curl vim exuberant-ctags xdg-utils tree zsh \
    ack-grep silversearcher-ag fd-find ripgrep \
    pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev

# Clean up packages
sudo apt autoremove -y
sudo apt autoclean -y

####################
### Install Rust ###
####################

# Make sure Rust isn't already installed
if [ ! -x "$CARGO_HOME/bin/rustup" ]; then
    # Get Rust installer and run it
    install_log "Installing Rust for cargo packages"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path --verbose -y
    "$CARGO_HOME/bin/rustup" override set stable
    "$CARGO_HOME/bin/rustup" update stable
fi

########################
### 'cargo' Packages ###
########################

install_log "Installing cargo packages"

# Explanation of apt packages:
#   1) Alacritty: fast (gpu-accelerated) terminal emulator
#   2) bat: Replacement for 'cat' with syntax-highlighting and 'git' integration
#   3) git-delta: Improved terminal 'git diff' viewer
"$CARGO_HOME/bin/cargo" install alacritty
"$CARGO_HOME/bin/cargo" install --locked bat
"$CARGO_HOME/bin/cargo" install git-delta

####################
### Python Setup ###
####################
# [NOTE]: Assumes installation of miniconda rather than anaconda
install_log "Setting up Python"

# Only install miniconda if it isn't already there
if [ ! -x "$HOME/miniconda3/condabin/conda" ]; then
    install_log "Installing miniconda environment manager"

    # Make miniconda directory & get latest Minconda release
    mkdir -p "$HOME/miniconda3"
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O "$HOME/miniconda3/miniconda.sh"

    # Call miniconda setup script with options:
    #   -b: agreements auto accepted
    #   -u: updates installation if directory already exists
    #   -p: specify directory to install into
    bash "$HOME/miniconda3/miniconda.sh" -b -u -p "$HOME/miniconda3"

    # Remove installation script
    rm -rf "$HOME/miniconda3/miniconda.sh"
fi

install_log "Installing base conda environment packages"
# Call update to conda itself for base environment
"$HOME/miniconda3/condabin/conda" update -y conda
# Conda install these to the base environment. I use these all the time, so that's fine
"$HOME/miniconda3/condabin/conda" install -y numpy matplotlib scipy flake8 pylint ipython jupyter yapf

install_log "Finished all installs!"
