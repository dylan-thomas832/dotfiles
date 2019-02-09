#!/usr/bin/env bash

set -e

# Packages to install

# Language support packages
code --install-extension ms-python.python                           # Python
code --install-extension ms-vscode.cpptools                         # C++
code --install-extension James-Yu.latex-workshop                    # Latex
code --install-extension yzhang.markdown-all-in-one                 # Markdown
code --install-extension redhat.vscode-yaml                         # YAML
code --install-extension dunstontc.viml                             # Vim scripts

# Language improvement packages
code --install-extension njpwerner.autodocstring                    # Auto-docstring for Python
code --install-extension christian-kohler.path-intellisense         # Intellisense for paths

# Themes & icons
code --install-extension zhuangtongfa.material-theme                # One Dark Pro theme
code --install-extension robertohuertasm.vscode-icons               # Better icons

# Utility extensions
code --install-extension alefragnani.project-manager                # Save project workspaces
code --install-extension alefragnani.bookmarks                      # Bookmark code-navigation
code --install-extension eamodio.gitlens                            # Improved Git integration
code --install-extension streetsidesoftware.code-spell-checker      # Spell-checker
