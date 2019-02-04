# Dotfile Shell Scripts

These are executables that help with setting up the dotfiles directory properly.


## Scripts used in install & update

- `aptget_upgrade.sh`
    - Perform "update" and "upgrade" tasks with package manager to get a new install up-to-date.

- `aptget_normal.sh`
    - Acquire required libraries/packages from package manager on new installs.
    - Regular install.

- `aptget_complete.sh`
    - Acquire all wanted libraries/packages from package manager on new installs.
    - "full installs" that include all packages

- `check_wsl.sh`
    - Check whether we are running the Linux "system" using WSL or natively. 
    - If native Linux distro, install the powerline-fonts for terminal directly
    - Otherwise, the user must download, open, and "install" them on the Windows side.

- `setup_vim.sh`
    - Copies vim color scheme files into the correct directory

## Helper Scripts

- `update_dotbot.sh`
    - Explicitly perform update to dotbot package. 
    - Also copies and overwrites root directories `install.sh` script.
    - Only needed if there's a major update to `install.sh`
    - Probably unecessary

- `setup_ohmyzsh.sh`
    - Perform functions to install oh-my-zsh framework
    - Deprecated, and basically not needed
    - Kept as a reference, for now
