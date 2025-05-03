#!/usr/bin/env bash
set -e

cd "$(dirname "${BASH_SOURCE}")";

if [ "$USER" == "root" ]; then
    echo 'This script is not intended to be run as root.'
    exit 1
fi

if [ -d ~/.dotfiles ]; then
  export DOTFILES="$HOME/.dotfiles"
elif [ -d /workspaces/.codespaces/.persistedshare/dotfiles ]; then
  export DOTFILES="/workspaces/.codespaces/.persistedshare/dotfiles"
  ln -sf "$DOTFILES" "$HOME/.dotfiles"
fi
echo "Using dotfiles at $DOTFILES"

[ -f "/usr/bin/zsh" ] && sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

# symlink common files
ln -sf "$DOTFILES/.zshrc" "$HOME/"
ln -sf "$DOTFILES/.gitconfig" "$HOME/"
ln -sf "$DOTFILES/.eslintrc.js" "$HOME/"

# AWS config
[ ! -d "$HOME/.aws" ] && mkdir "$HOME/.aws"
[ ! -d "$HOME/.awsvault/keys" ] && mkdir -p "$HOME/.awsvault/keys"

# code cli
if [ -d "/home/$USER/.vscode-server/bin" ]; then
  export PATH="/home/$USER/.vscode-server/bin/*/bin:$PATH"
elif [ -d "/home/$USER/.vscode-server-insiders/bin" ]; then
  export PATH="/home/$USER/.vscode-server-insiders/bin/*/bin:$PATH"
fi

exit 0
