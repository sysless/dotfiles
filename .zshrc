# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
DEFAULT_USER=$USER

COMPLETION_WAITING_DOTS="true"

plugins=(sudo git aws pip python virtualenv brew docker ssh-agent)

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/sbin:/usr/bin:/sbin:/bin"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/Users/hiten/.local/bin:$PATH"

export EDITOR='code'

# code cli
if [ -d "/home/$USER/.vscode-server/bin" ]; then
  vscode_path=$(find /home/$USER/.vscode-server/bin -maxdepth 1 -type l | tail -n 1)
  if [ -n "$vscode_path" ]; then
    export PATH="$vscode_path/bin/remote-cli:$PATH"
  fi
elif [ -d "/home/$USER/.vscode-server-insiders/bin" ]; then
  vscode_path=$(find /home/$USER/.vscode-server-insiders/bin -maxdepth 1 -type l | tail -n 1)
  if [ ! -f "$HOME/.bin/code" ]; then
    mkdir -p "$HOME/.bin"
    ln -sf "$vscode_path/bin/remote-cli/code-insiders" "$HOME/.bin/code"
  fi
  export PATH="$HOME/.bin:$PATH"
fi

source $ZSH/oh-my-zsh.sh

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# host specific configuration
if [ -f $HOME/.myzshrc ]; then
  source ~/.myzshrc
fi

unset NPM_CONFIG_PREFIX
if [ -x "$(command -v brew)" ]; then
  source $(brew --prefix nvm)/nvm.sh  # This loads nvm
  source $(brew --prefix nvm)/etc/bash_completion.d/nvm  # This loads bash_completion
fi

if [ -x "$(command -v rbenv)" ]; then
  eval "$(rbenv init - zsh)"
fi

export HISTFILE="$HOME/.zsh_history"
