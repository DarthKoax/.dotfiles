#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Dotfiles directory: ${DOTFILES_DIR}"
echo "Install script is a skeleton - configure symlinks as needed."



## TODO
# * Install fonts dir
# * Install fzf
# * Install nvim, in bin dir. see current nvim
# * Install nvim lsp, linters etc. 
# * Download mason directory and sed replace download url
# * setup gitconfig
# * setup opencode
