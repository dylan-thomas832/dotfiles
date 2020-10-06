# Zsh configurations

## Features

Note: any `*.sh` files in `~/.login.d/` **will** get sourced

* `~/.bash_profile`
  * sourced by interactive login shells
  * sources `~/.bashrc`
* `~/.bashrc`
  * sourced by interactive non-login shells
  * sources `~/.zshrc`
* `~/.zlogin`
  * sourced by interactive login shells after `~/.zshrc`
  * sources all `*.sh` files in `~/.login.d/`
* `~/.zshrc`
  * sourced by interactive shells
  * sources specified `*.zsh` files in `~/.zshrc.d/`
* `~/.zshrc.d/`
  * stores zsh-specific config files
* `~/.login.d/`
  * stores config files for login shells
