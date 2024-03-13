# Path to your oh-my-zsh installation.

export ZSH=$HOME/.oh-my-zsh

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="alexrtz"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(sudo git fzf)

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.zsh_custom

. $ZSH/oh-my-zsh.sh

# User configuration

# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_CA.UTF-8
export LC_ALL=en_CA.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

PATH=/bin:/sbin:/usr/bin:/usr/sbin

SHELL_CONFIG_DIR=~/.config/mine/shell_common

[ -f $SHELL_CONFIG_DIR/variables.sh ] && . $SHELL_CONFIG_DIR/variables.sh
[ -f $SHELL_CONFIG_DIR/aliases.sh ] && . $SHELL_CONFIG_DIR/aliases.sh
[ -f $SHELL_CONFIG_DIR/functions.sh ] && . $SHELL_CONFIG_DIR/functions.sh
#[ -f $SHELL_CONFIG_DIR/ssh.sh ] && . $SHELL_CONFIG_DIR/ssh.sh

autoload bashcompinit
bashcompinit

[ -f ~/.bash_specific_config ] && . ~/.bash_specific_config

[ -f ~/.rvm/scripts/rvm ] && source ~/.rvm/scripts/rvm

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

#rvm use ruby > /dev/null

which direnv > /dev/null 2>&1
[ $? -eq 0 ] && eval "$(direnv hook zsh)"
