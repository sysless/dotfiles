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
  brew install jq nvm yarn

  # Node
  source $(brew --prefix nvm)/nvm.sh
  nvm install --lts # Install the latest LTS version

  # Sharp (https://github.com/lovell/sharp/issues/2460#issuecomment-740467735)
  # brew install pkg-config glib zlib vips libjpeg-turbo libpng webp mas rbenv ruby-build pyenv

  # Ruby global
  brew install rbenv ruby-build

  # Python global
  brew install python pyenv
  #pyenv install 3.10.8
  #pyenv global 3.10.8

  # Cask
  brew install --cask raycast google-chrome vlc spotify android-file-transfer discord whatsapp firefox superhuman elgato-control-center grammarly-desktop notion-calendar
  # Cask Dev
  brew install --cask visual-studio-code aws-vault figma google-cloud-sdk docker
  # Cask 3D printing
  softwareupdate --install-rosetta --agree-to-license # required for autodesk-fusion
  brew install --cask bambu-studio # autodesk-fusion
  # Mac App Store
  brew install mas
  mas install 803453959 # Slack
  mas install 497799835 # Xcode
  mas install 425424353 # The Unarchiver
  mas install 1193539993 # Brother iPrint&Scan
  mas install 1475387142 # Tailscale
  mas upgrade

  # React Native
  # brew install android-studio android-platform-tools watchman fastlane cocoapods
  # brew tap homebrew/cask-versions
  # brew install zulu8

  # DBT
  # brew tap dbt-labs/dbt
  # brew install dbt-bigquery

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