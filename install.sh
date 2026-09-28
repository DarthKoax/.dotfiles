#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Dotfiles directory: ${DOTFILES_DIR}"
echo "Install script is a skeleton - configure symlinks as needed."


cat >> ~/.bashrc <<'EOF'
if [ -f ~/.dotfiles/.bashrc ]; then
    source ~/.dotfiles/.bashrc
fi
EOF

ln -s "${DOTFILES_DIR}/configs/tmux/.tmux.conf" ~/.tmux.conf 2> /dev/null || true
mkdir -p ~/.tmux/plugins/ 2> /dev/null || true
cd ~/.tmux/plugins/
git clone https://github.com/tmux-plugins/tpm.git 2> /dev/null || true
git clone https://github.com/tmux-plugins/tpm.git 2> /dev/null || true
git clone https://github.com/tmux-plugins/tpm.git 2> /dev/null || true

## TODO
# * Install fonts dir
# * Install fzf
# * Install nvim, in bin dir. see current nvim
# * Install nvim lsp, linters etc. 
# * Download mason directory and sed replace download url
# * setup gitconfig
# * setup opencode
