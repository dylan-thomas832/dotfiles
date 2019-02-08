#!/bin/bash

if grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null ; then
  echo "This is a WSL system"
  if [ -f ~/etc/ ]; then
    cat ~/etc/os-release
  fi
else
  echo "This is not a WSL system"
  if [ -f ~/etc/ ]; then
    cat ~/etc/os-release
  fi
fi
