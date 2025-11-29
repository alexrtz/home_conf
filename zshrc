# Path to your oh-my-zsh installation.

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

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


export ZSH=$HOME/.config/zsh/oh-my-zsh
export ZSH_CUSTOM=~/.config/zsh/custom/
ZSH_THEME="alexrtz"
source $ZSH/oh-my-zsh.sh


# You may need to manually set your language environment
export LANG=en_CA.UTF-8
export LC_ALL=en_CA.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

PATH=/bin:/sbin:/usr/bin:/usr/sbin

SHELL_CONFIG_DIR=~/.config/mine/shell_common

[ -f $SHELL_CONFIG_DIR/variables.sh ] && . $SHELL_CONFIG_DIR/variables.sh
[ -f $SHELL_CONFIG_DIR/aliases.sh ] && . $SHELL_CONFIG_DIR/aliases.sh
[ -f $SHELL_CONFIG_DIR/functions.sh ] && . $SHELL_CONFIG_DIR/functions.sh
[ -f $SHELL_CONFIG_DIR/init.sh ] && . $SHELL_CONFIG_DIR/init.sh
#[ -f $SHELL_CONFIG_DIR/ssh.sh ] && . $SHELL_CONFIG_DIR/ssh.sh

alias find="noglob find"

autoload bashcompinit
bashcompinit

[ -f ~/.bash_specific_config ] && . ~/.bash_specific_config

which direnv > /dev/null 2>&1
[ $? -eq 0 ] && eval "$(direnv hook zsh)"
