# /etc/skel/.bashrc:
# $Header: /home/cvsroot/gentoo-src/rc-scripts/etc/skel/.bashrc,v 1.8 2003/02/28 15:45:35 azarah Exp $

# This file is sourced by all *interactive* bash shells on startup.  This
# file *should generate no output* or it will break the scp and rcp commands.

HISTFILE=~/.bash_history
HISTSIZE=2048
HISTFILESIZE=1048576
HISTCONTROL=ignoredups

[ -f /etc/bash_completion ] && . /etc/bash_completion

[ -f /etc/profile.d/bash_completion.sh ] && . /etc/profile.d/bash_completion.sh

[ -f ~/.bash_completion.d/ctest ] && . ~/.bash_completion.d/ctest

[ -f ~/.bash_completion.d/git ] && . ~/.bash_completion.d/git

if [ -f /etc/bash_completion.d/git ]; then
    . /etc/bash_completion.d/git
     complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
-        || complete -o default -o nospace -F _git g
fi


if [ -f /etc/bash_completion.d/git-prompt ]; then
    . /etc/bash_completion.d/git-prompt
     complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
-        || complete -o default -o nospace -F _git g
fi


if [ -f /usr/share/bash-completion/git ]; then
    . /usr/share/bash-completion/git
     complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
-        || complete -o default -o nospace -F _git g
fi

if [ -f /usr/share/bash-completion/completions/git ]; then
    . /usr/share/bash-completion/completions/git
     complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
-        || complete -o default -o nospace -F _git g
fi


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"


# alias gitarch="git archive master --format=tar --prefix=`pwd | sed -e 's/\// /g' |awk '{print $NF}'`/ | gzip >`pwd | sed -e 's/\// /g' |awk '{print $NF}'`.tgz"


SHELL_CONFIG_DIR=~/.config/mine/shell_common

[ -f ~/.bash_specific_config ] && . ~/.bash_specific_config
[ -f $SHELL_CONFIG_DIR/variables.sh ] && . $SHELL_CONFIG_DIR/variables.sh
[ -f $SHELL_CONFIG_DIR/aliases.sh ] && . $SHELL_CONFIG_DIR/aliases.sh
[ -f $SHELL_CONFIG_DIR/functions.sh ] && . $SHELL_CONFIG_DIR/functions.sh
#[ -f $SHELL_CONFIG_DIR/ssh.sh ] && . $SHELL_CONFIG_DIR/ssh.sh


# https://github.com/nicolargo/dotfiles/blob/master/_bashrc.d/bashrc_prompt

Yellow="\033[01;33m"
Cyan="\033[01;36m"
Green="\033[0;32m"
Red="\033[0;31m"
NoColor="\033[0m"

RootPrompt="\#"
NonRootPrompt="\$"

prompt() {

    USERNAME=$SHELL_USERNAME
    HOSTNAME=`hostname -s`

    WINDOWTITLE="$USERNAME@$HOSTNAME"
    echo -ne "\033]0;$WINDOWTITLE\007"

    LEFTPROMPT="\[$Yellow\]$USERNAME@$HOSTNAME \[$Cyan\]\W"

    BRANCH=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [ $? -eq 0 ]; then
        LEFTPROMPT=$LEFTPROMPT" ["$BRANCH"]"
    else
        BRANCH=$(hg branch 2> /dev/null)
        [ $? -eq 0 ] && LEFTPROMPT=$LEFTPROMPT" ["$BRANCH"]"
    fi

    LineEnding="\n"

    [ ${#LEFT_PROMPT}  -lt 30 ] && LineEnding=" "

    if [ $EUID -ne 0 ]; then
        PS1=$LEFTPROMPT"\[$Cyan\] "$NonRootPrompt"\[$NoColor\]"$LineEnding
    else
        PS1=$LEFTPROMPT"\[$Red\] "$RootPrompt$LineEnding
    fi
}

if [ -z "$PROMPT_COMMAND" ]; then
    case $TERM in
	xterm*)
	    PROMPT_COMMAND='printf "\033]0;%s@%s %s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
	    ;;
	screen)
	    PROMPT_COMMAND='printf "\033]0;%s@%s %s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
	    ;;
    esac
fi

PROMPT_COMMAND="prompt;$PROMPT_COMMAND"

if [ $EUID -ne 0 ]; then
    PS1=$NonRootPrompt" "
else
    PS1=$RootPrompt" "
fi

#[ -f /etc/profile.d/rvm.sh ] && . /etc/profile.d/rvm.sh && rvm use ruby > /dev/null

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
