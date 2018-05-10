#!/bin/bash

set -e

# Get usual python environment setup
python -m pip install --user numpy scipy matplotlib pandas tqdm concurrent-log-handler ipython cython jupyter

# Python 3
python3 -m pip install --user numpy scipy matplotlib pandas tqdm concurrent-log-handler ipython cython jupyter

echo "Finished Python package installs!"

