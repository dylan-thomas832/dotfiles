# Dotfile Shell Scripts

These are executables that help with setting up the dotfiles directory properly.


## Scripts used in install & update

- `new_install_update.sh`
    - Perform "update" and "upgrade" tasks with package manager to get a new install up-to-date.

- `aptget_packages.sh`
    - Acquire wanted libraries/packages from package manager on new installs.
    - __NOTE__: I may refactor only the necessary packages into this. Then, there may be a secondary
install.conf.yaml for "full installs" that include all packages.

- `check_for_wsl.sh`
    - Check whether we are running the Linux "system" using WSL or natively. 
    - If native Linux distro, install the powerline-fonts for terminal directly
    - Otherwise, the user must download, open, and "install" them on the Windows side.

- `vim_setup.sh`
    - Copies vim color scheme files into the correct directory

## Helper Scripts

- `update_dotbot.sh`
    - Explicitly perform update to dotbot package. 
    - Also copies and overwrites root directories `install.sh` script.
    - Only needed if there's a major update to `install.sh`
    - Probably unecessary

- `get_ohmyzsh.sh`
    - Perform functions to install oh-my-zsh framework
    - Deprecated, and basically not needed
    - Kept as a reference, for now
