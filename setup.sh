#!/usr/bin/env bash
set -e

cd "$(dirname "${BASH_SOURCE}")";

if [ "$USER" == "root" ]; then
    echo 'This script is not intended to be run as root.'
    exit 1
fi

[ ! -d ~/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

if [ `uname` == "Darwin" ]; then
  xcode-select -p
  [ "$?" == "2" ] && xcode-select --install

  # Brew packages
  [ ! -f /usr/local/bin/brew ] && [ ! -f /opt/homebrew/bin/brew ] && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  export PATH=$PATH:/opt/homebrew/bin

  # Cask
  brew install --cask raycast google-chrome vlc spotify android-file-transfer discord whatsapp firefox superhuman elgato-control-center grammarly-desktop notion-calendar
  # Cask Dev
  brew install --cask visual-studio-code figma docker
  # Mac App Store
  brew install mas
  mas install 803453959 # Slack
  mas install 497799835 # Xcode
  mas install 425424353 # The Unarchiver
  mas install 1193539993 # Brother iPrint&Scan
  mas upgrade

  [ ! -L ~/.myzshrc ] && ln -sf $DOTFILES/.myzshrc_mac ~/.myzshrc
  [ "$SHELL" != "/bin/zsh" ] && chpass -s /bin/zsh

  # symlink /home for compatibility with linux
  [ ! -L /home ] && sudo sed -i.bak 's|/home|#/home|' /etc/auto_master && \
    sudo automount -cv && \
    sudo rm -rf /home && \
    sudo ln -s /Users /home

  [ ! -d ~/Downloads/screencapture ] && mkdir ~/Downloads/screencapture && \
  defaults write com.apple.screencapture location /Users/hiten/Downloads/screencapture
  defaults write com.apple.Finder AppleShowAllFiles true

  # TODO: install powerline fonts
  # TODO: change default browser
  # TODO: sound icon
  # TODO: bluetooth icon
  # TODO: disable spotlight
  # TODO: install kensington works
elif [ `uname` == "Linux" ]; then
  # Linux?
	[ ! -f ~/.fonts/Monaco\ for\ Powerline.otf ] && wget -P ~/.fonts/ https://raw.githubusercontent.com/supermarin/powerline-fonts/master/Monaco/Monaco%20for%20Powerline.otf
fi

exit 0