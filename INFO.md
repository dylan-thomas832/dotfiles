# Dotfiles

This repository contains machine-specific configuration to accompany my dotfiles.

## Installation

For installing a predefined profile:
```bash
~/.dotfiles$ ./install-profile <profile> [<configs...>]
# see meta/profiles/ for available profiles
```

For installing single configurations:
```bash
~/.dotfiles$ ./install-standalone <configs...>
# see meta/configs/ for available configurations
```

You can run these installation commands safely multiple times, if you think that helps with better installation.

## Contents

### Profiles

I have three profiles currently setup: Linux for Ubuntu desktop, Windows for use with Cmder, and Windows Subsystem for Linux

```
meta/profiles/
├── windows
└── linux 
```
### Dotbot configurations

Current configuration options. Some of these have Linux/windows varieties.

```
meta/configs/
├── bash
├── git
├── linux
├── python
├── sh
├── terminal
├── vim
├── vscode
└── zsh
```
