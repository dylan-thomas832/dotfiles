# Dotfile Shell Scripts

These are executables that help with setting up the dotfiles directory properly.


## Scripts used in install & update

- `linux-install.sh`
    - Acquire all wanted libraries/packages from package manager on new installs.
    - "full installs" that include all packages

- `check_distribution.sh`
    - Check whether we are running the Linux "system" using WSL or natively. 
    - If native Linux distro, install the powerline-fonts for terminal directly
    - Otherwise, the user must download, open, and "install" them on the Windows side.
