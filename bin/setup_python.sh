#!/usr/bin/env bash

set -e

if [ ! -x  ~/anaconda3/condabin/conda ] && [ ! -x ~/miniconda3/condabin/conda ]; then
    echo "Please install conda before proceeding"
    exit 2
fi

# Conda install these to the base environment. I use these all the time, so that's fine
conda install numpy matplotlib scipy flake8 pylint ipython jupyter yapf
