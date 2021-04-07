#!/usr/bin/env bash

### This script was frankensteined from https://github.com/dylanaraps/pfetch
## This should be a relatively stable/safe way to check your distribution

# This is just a simple wrapper around 'command -v' to avoid
# spamming '>/dev/null' throughout this function. This also guards
# against aliases and functions.
has() {
    _cmd=$(command -v "$1") 2>/dev/null || return 1
    [ -x "$_cmd" ] || return 1
}

# Some Linux distributions (which are based on others)
# fail to identify as they **do not** change the upstream
# distribution's identification packages or files.
#
# It is senseless to add a special case in the code for
# each and every distribution (which _is_ technically no
# different from what it is based on) as they're either too
# lazy to modify upstream's identification files or they
# don't have the know-how (or means) to ship their own
# lsb-release package.
#
# This causes users to think there's a bug in system detection
# tools like neofetch or pfetch when they technically *do*
# function correctly.
#
# Exceptions are made for distributions which are independent,
# not based on another distribution or follow different
# standards.
#
# This applies only to distributions which follow the standard
# by shipping unmodified identification files and packages
# from their respective upstreams.
if has lsb_release; then
    distro=$(lsb_release -sd)

# Android detection works by checking for the existence of
# the follow two directories. I don't think there's a simpler
# method than this.
elif [ -d /system/app ] && [ -d /system/priv-app ]; then
    distro="Android $(getprop ro.build.version.release)"

else
    # This used to be a simple '. /etc/os-release' but I believe
    # this is insecure as we blindly executed whatever was in the
    # file. This parser instead simply handles 'key=val', treating
    # the file contents as plain-text.
    while IFS='=' read -r key val; do
        case $key in
            (PRETTY_NAME)
                distro=$val
            ;;
        esac
    done < /etc/os-release
fi

# 'os-release' and 'lsb_release' sometimes add quotes
# around the distribution name, strip them.
distro=${distro##[\"\']}
distro=${distro%%[\"\']}

# Check to see if Linux is running in Windows 10 under
# WSL2 (Windows subsystem for Linux [version 2]) and
# append a string accordingly.
#
# This checks to see if '$WSLENV' is defined. This
# appends the Windows 10 string even if '$WSLENV' is
# empty. We only need to check that is has been _exported_.
if [ "$WSLENV" ]; then
    distro="${distro}${WSLENV+ on Windows 10 [WSL2]}"

# Check to see if Linux is running in Windows 10 under
# WSL1 (Windows subsystem for Linux [version 1]) and
# append a string accordingly.
#
# If the kernel version string ends in "-Microsoft",
# we're very likely running under Windows 10 in WSL1.
elif [ -z "${kernel%%*-Microsoft}" ]; then
    distro="$distro on Windows 10 [WSL1]"
fi

echo $distro
