# Dylan Thomas' Dotfiles Repo

This is the main repo for all my generic dotfiles.

## Installing

Clone the repository to somewhere you like to store git repos. 

```bash
git clone git@github.com:dylan93/dotfiles.git
```

__NOTE__: it must not be cloned into ~/.dotfiles
This will clone the directory to its desired location, and change into that directory.

Next, run the `dotfile_install` script (without sudo!):

```bash
./dotfile_install
```

Everything should be taken care of by this script. __NOTE__: This requires elevation (sudo), so be prepared to enter your password. This will install only the necessary packages.

To run a complete install (full set of dev apt packages):

```bash
./dotfile_install -c install_complete.conf.yaml
```


## Updating

Simply run the following to update submodules/packages for dotfiles:

```bash
./dotfile_install -c update.conf.yaml
```

To explicitly update dotbot and copy over a new `dotfile_install` file:

```bash
./bin/update_dotbot.sh
```

Fast forward all submodules to upstream origin/master. Only does master branch.
```shell
git submodule foreach git pull origin master --recursive
```


## Troubleshooting

- Inspect __logs/__ directory for script outputs & errors!
- Try changing permissions on shell scripts: 

```bash
chmod +x -R ~./dotfiles/bin/*
```

- Run check for WSL, which may cause issues:

```bash
./bin/check_wsl.sh
```


## Dependencies for WSL only

- VcXsrv
- wsl-terminal (rosipov theme, DejaVu Sans Mono font)
- Need to install fonts from *.tff file!
- Install mintty themes to wsltty/themes !


## General Dependencies
- zsh, oh-my-zsh
- Ack & Ag for vim (pathogen)

## Info

[dotbot](https://github.com/anishathalye/dotbot/)
[install profiles](https://github.com/shivapoudel/dotfiles)
