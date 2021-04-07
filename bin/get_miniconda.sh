#!/usr/bin/env bash

set -e

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

# Tell user to run conda init, and put into local bashrc

echo "\t1) Please run 'conda init -dv $SHELL'"
echo "\t2) Copy the lines from (inclusive)"
echo "\n\t# >>> conda initialize>>> \n\n\t\t\t to\n\n\t# <<< conda initialize <<<\n"
echo "\t3) Paste into either '~/.bashrc_local_after' or '~/.zshrc_local_after' depending on your SHELL" 
