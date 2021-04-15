#!/usr/bin/env bash

set -e

# Update/upgrade package
echo "\n\tUpdating & upgrading packages.\n"
sudo apt update && apt upgrade -y

# Pretty basic setup
echo "\n\tInstalling apt packages.\n"
sudo apt install -y \\
    # Mostly C/C++/Fortran essentials
    build-essential gfortran cmake cmake-curses-gui \\
    # Ensure update-to-date python
    python3-dev python3-pip python3-tk \\
    # BLAS/LAPACK linear algebra libraries
    libopenblas-dev libatlas-base-dev liblapack-dev \\
    # Useful dev tools
    git wget curl vim ctags xdg-utils tree \\
    # Nice upgrades to standard search tools
    ack-grep silversearcher-ag fd-find ripgrep \\
    # Extra requirements for alacritty terminal
    pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev
sudo apt autoremove -y

# Get Rust installer and run it
echo "\n\tInstalling Rust for cargo packages\n"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path --verbose
${CARGO_HOME}/bin/rustup override set stable
${CARGO_HOME}/bin/rustup update stable

## Cargo installs
echo "\n\tInstalling cargo packages\n"

# Install Alacritty (fast terminal emulator)
cargo install alacritty

# Install bat (cat, but with color)
cargo install --locked bat

# Install delta (better termina git diff viewer)
cargo install git-delta

## Python installs
echo "\n\tSetting up Python\n"

if [ ! -x ~/miniconda3/condabin/conda ]; then
    echo "\n\tInstalling miniconda environment manager\n"

    # Make miniconda directory & get latest Minconda release
    mkdir -p ~/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh

    # Call miniconda setup script with options:
    #   -b: agreements auto accepted
    #   -u: updates installation if directory already exists
    #   -p: specify directory to install into
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3

    # Remove installation script
    rm -rf ~/miniconda3/miniconda.sh

    # Call update to conda itself for base environment
    ~/miniconda3/condabin/conda update -y conda
fi

echo "\n\tInstalling base conda environment packages\n"
# Conda install these to the base environment. I use these all the time, so that's fine
~/miniconda3/condabin/conda install -y numpy matplotlib scipy flake8 pylint ipython jupyter yapf

echo "\n\tFinished all installs!"
