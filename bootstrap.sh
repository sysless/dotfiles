#!/usr/bin/env bash
set -e

cd "$(dirname "${BASH_SOURCE}")";

if [ "$USER" == "root" ]; then
    echo 'This script is not intended to be run as root.'
    exit 1
fi

if [ -d ~/.dotfiles ]; then
  export DOTFILES="~/.dotfiles"
elif [ -d /workspaces/.codespaces/.persistedshare/dotfiles ]; then
  export DOTFILES="/workspaces/.codespaces/.persistedshare/dotfiles"
  ln -sf $DOTFILES ~/.dotfiles
fi

# symlink common files
[ ! -L ~/.zshrc ] && ln -sf $DOTFILES/.zshrc ~/.zshrc
[ ! -L ~/.emacs ] && ln -sf $DOTFILES/.emacs ~/
[ ! -L ~/.gitconfig ] && ln -sf $DOTFILES/.gitconfig ~/
[ ! -L ~/.eslintrc.js ] && ln -sf $DOTFILES/.eslintrc.js ~/

exit 0
