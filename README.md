# Dylan Thomas' Dotfiles Repo

This is the main repo for all my generic dotfiles.

## Installing

Run the following:

    ```shell
        git clone git@gitlab.hume.vt.edu:dylan93/dotfiles.git ~/.dotfiles && cd ~/.dotfiles
    ```
This will clone the directory to its desired location, and change into that directory.

Next, run the install script (without sudo!):

    ```shell
        ./install
    ```
Everything should be taken care of by this script. __NOTE__: This requires elevation (sudo), so be prepared to enter your password.


## Updating

Simply run the following to update submodules/packages for dotfiles:

    ```shell
        ./install -c update_modules.conf.yaml
    ```

To explicitly update dotbot and copy over a new install.sh file:

    ```shell
        ./bin/update_dotbot.sh
    ```


## Troubleshooting

- Inspect __logs/__ directory for script outputs & errors!
- Try changing permissions on shell scripts: 

    ```shell
        chmod +x -R ~./dotfiles/bin/*
    ```
- Run check for WSL, which may cause issues:

    ```shell
        ./bin/check_for_wsl.sh
    ```


## Dependencies for WSL only

- VcXsrv
- wsl-terminal (rosipov theme, DejaVu Sans Mono font)
- Need to install fonts from *.tff file!
- Install mintty themes to wsltty/themes !


## General Dependencies
- zsh, oh-my-zsh
- Ack & Ag for vim (pathogen)
