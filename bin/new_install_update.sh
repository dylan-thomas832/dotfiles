#!/bin/bash

set -e

#
# Use apt to get necessary packages
#

# Update/upgrade package
apt-get update
apt-get upgrade -y

echo "Finished update and upgrade!"

