# Dylan Thomas' Dotfiles Repo

This is the main repo for all my generic dotfiles.

**Checkout [INFO.md](./INFO.md) for more information!**

## Windows Installation

List of required & recommended external programs that haven't been automated.

- Required:
  - **VSCode**, for a GUI text editor
  - **Cmder**, for Linux-esque terminal emulation

- Possible pre-requirements:
  - **Ctags**, for better Vim navigation
  - **Chocolatey**, for improving Vim searching
  - **Texlive**, for writing LaTeX documents

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

#### [ctags](http://ctags.sourceforge.net/)

1. Download and extract 
1. I put them at __C:/ctags58/__
    - Add this to your environment path
  
#### [chocolatey](https://chocolatey.org/install)

1. Download and install  (requires elevation)
1. Once installed, from *cmd.exe*, run
    ```powershell
    choco install -y ack ag
    ```

#### [texlive](https://tug.org/texlive/acquire-netinstall.html)

1. Download and install 
    - This takes a __very__ long time
1. I install it to __C:/texlive/__
    - Add __C:/texlive/"year"/bin/win32__ to your path

### Installation procedure

1. In Cmder, open a bash terminal **as an administrator** - {bash::bash as Admin}
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
1. In Cmder, open a cmd terminal **as an administrator**  - {cmd::Cmder}
1. Run this command to setup the dotfiles
    ```powershell
    sh ./install-profile windows
    ```
    - You can edit the configurations included by alterin __meta/profiles/windows__
1. In the Cmder bash shell, to setup Visual Studio Code extensions, run:
    ```bash
    ./bin/install-vscode-extensions
    ```

## WSL Installation

TBD

## Linux Installation

TBD

## Updating

Fast forward all submodules to upstream origin/master. Only does master branch. TBD
```shell
git submodule foreach git pull origin master --recursive
```

## Troubleshooting

- Try changing permissions on shell scripts: 

```bash
chmod +x -R ~./dotfiles/bin/*
```

## Dependencies for WSL only

- VcXsrv
- wsl-terminal (rosipov theme, DejaVu Sans Mono font)
- Need to install fonts from *.tff file!
- Install mintty themes to wsltty/themes !

## General Dependencies
- zsh, oh-my-zsh
- Ack & Ag for vim (pathogen)

## TODO

* split apt-get update into various package options (BLAS/ Build/ etc.). 
  * Put in own config file. Not apart of any profile
* remove submodule for oh-my-zsh. Add it to a config?
* Determine and add tmux configs

## Info

[dotbot](https://github.com/anishathalye/dotbot/)
[install profiles](https://github.com/shivapoudel/dotfiles)

## License

Copyright (c) 2019 Dylan Thomas | Licensed under [MIT license](https://dylanthomas.mit-license.org/)
