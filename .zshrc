# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"
DEFAULT_USER=$USER

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(sudo git aws pip python virtualenv brew docker ssh-agent)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/sbin:/usr/bin:/sbin:/bin"
export PATH="/opt/homebrew/bin:$PATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='emacs'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias emacs="emacsclient -nw"
alias e="emacs"
alias aws-mfa=". $HOME/.dotfiles/aws-mfa.sh"

# host specific configuration
if [ -f $HOME/.myzshrc ]; then
  source ~/.myzshrc
fi

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME/Downloads/google-cloud-sdk/path.zsh.inc ]; then
  source "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"
fi

# The next line enables shell command completion for gcloud.
if [ -f $HOME/Downloads/google-cloud-sdk/completion.zsh.inc ]; then
  source "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"
fi

unset NPM_CONFIG_PREFIX
export NVM_DIR="$HOME/.nvm"
if [ -x "$(command -v brew)" ]; then
  source $(brew --prefix nvm)/nvm.sh  # This loads nvm
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="$PATH:$HOME/Library/Python/2.7/bin"
export PATH="$PATH:$HOME/Library/Python/3.8/bin"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/hiten/.nvm/versions/node/v8.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/hiten/.nvm/versions/node/v8.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/hiten/.nvm/versions/node/v8.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/hiten/.nvm/versions/node/v8.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# aws-vault
export AWS_VAULT_KEYCHAIN_NAME="login"
function aws-login() { aws-vault login --stdout "$@" | xargs -t /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --incognito --new-window }
alias aws-login=aws-login

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/hiten/.nvm/versions/node/v8.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/hiten/.nvm/versions/node/v8.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh

if [ ! -z "${VSONLINE_BUILD}" ]; then
  export PATH=$PATH:/opt/oryx:/opt/nodejs/lts/bin:/opt/dotnet/sdks/lts:/opt/python/latest/bin:/opt/yarn/stable/bin:~/.local/bin:~/.npm-global/bin
fi

export PATH="$HOME/.fastlane/bin:$PATH"

eval "$(rbenv init -)"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"