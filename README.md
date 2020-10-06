# Dylan Thomas' Dotfiles Repo

This is the main repo for all my generic dotfiles.

**Checkout [INFO.md](./INFO.md) for more information!**

## Windows Installation

List of required & recommended external programs that haven't been automated.

**Note**:  Make sure you set your git settings to "autocrlf=false" first

- Required:
  - **Miniconda**, for setting up Python
  - **VSCode**, for a GUI text editor
  - **Cmder**, for Linux-esque terminal emulation
- Optional:
  - **Windows Terminal**, for sleek terminal in Windows!
  - **WSLtty**, if Windows Terminal isn't available for your build
  - **VcXsrv**, Windows X Server for graphical programs

#### [miniconda](https://docs.conda.io/en/latest/miniconda.html)
1. Download and install the 64-bit version
1. Add installation folder to path, so `python` command is recognized

#### [vscode](https://code.visualstudio.com/)

1. Download and install the User version
1. Add to environment path for ease

#### [cmder](http://cmder.net/)
 
1. Download and install the full version 
1. Put the folder at __C:/Users/"user-name"/cmder__
    - Add to path
1. Create the environment variable `%CMDER_ROOT%` for it's location
1. From *cmd.exe*, run 
    ```powershell
    cmder.exe /register USER
    ```

#### [terminal](https://github.com/microsoft/terminal)

1. Install through the app store or other method

#### [wsltty](https://github.com/mintty/wsltty)

1. Install using the standalone installer

#### [VcXsrv](https://sourceforge.net/projects/vcxsrv/)

1. Download and install

### Installation procedure

1. In Cmder, open a bash terminal **as an administrator** - {bash::bash as Admin} and check the button
1. To clone the repo and ensure "LF" line endings are used:
    ```bash
    git config core.autocrlf=false
    git clone https://github.com/dylan93/dotfiles.git
    cd dotfiles
    ```
1. Run this to allow for symbolic links
    ```bash 
    export MSYS=winsymlinks:nativestrict
    ```
1. In Cmder, open a cmd terminal **as an administrator**  - {cmd::Cmder} and check the button
1. Run this command to setup the dotfiles
    ```powershell
    sh ./install-profile windows
    ```
    - You can edit the configurations included by altering __meta/profiles/windows__
1. To install Windows Terminal settings, open the app, and copy over the settings from __terminal/windows/profiles.json__
1. Install vscode extensions that you want

## Linux/WSL Installation

1. Install apt packages
    ```bash
    sudo ./bin/linux-install.sh
    ```
1. Ensure *zsh* is installed:
    ```bash
    $ which zsh
    $ zsh --version
    ```
1. If not installed, install via:
    ```bash
    $ sudo apt install zsh
    ```
1. Make *zsh* the default shell
    ```bash
    $ chsh -s $(which zsh)
    ```
1. Perform dotfile install
    ```bash
    ./install-profile linux
    ```

## Updating

Fast forward all submodules to upstream origin/master. Only does master branch. TBD
```shell
git submodule foreach git pull origin master
```

## Troubleshooting

- Try changing permissions on shell scripts: 

```bash
chmod +x -R ~./dotfiles/bin/*
```

## Dependencies for WSL only

- VcXsrv
- Need to install fonts from *.tff file!
- Install mintty themes to wsltty/themes !

## General Dependencies
- zsh, oh-my-zsh
- Ack & Ag for vim (pathogen)

## Info

[dotbot](https://github.com/anishathalye/dotbot/)
[install profiles](https://github.com/shivapoudel/dotfiles)

## License

Copyright (c) 2019 Dylan Thomas | Licensed under [MIT license](https://dylanthomas.mit-license.org/)
