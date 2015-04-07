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


#[ -f ~/.shell_common/aliases.sh ] && . ~/.shell_common/aliases.sh
#[ -f ~/.shell_common/variables.sh ] && . ~/.shell_common/variables.sh
#[ -f ~/.shell_common/ssh.sh ] && . ~/.shell_common/ssh.sh
#[ -f ~/.bash_specific_config ] && . ~/.bash_specific_config

# https://github.com/nicolargo/dotfiles/blob/master/_bashrc.d/bashrc_prompt

# Colors

Yellow="\033[01;33m"
Cyan="\033[01;36m"
Green="\033[0;32m"
Red="\033[0;31m"
NoColor="\033[0m"

# Chars
RootPrompt="\#"
NonRootPrompt="\$"

# Contextual prompt
prompt() {

    USERNAME=$SHELL_USERNAME
    HOSTNAME=`hostname -s`
#CURRENTPATH=`pwd | sed "s|$HOME|~|g"`

# Change the Window title
    WINDOWTITLE="$USERNAME@$HOSTNAME"
    echo -ne "\033]0;$WINDOWTITLE\007"

# Change the dynamic prompt
#LEFTPROMPT="$Yellow$CURRENTPATH"
    LEFTPROMPT="\[$Yellow\]$USERNAME@$HOSTNAME \[$Cyan\]\W"

    BRANCH=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [ $? -eq 0 ]; then
	LEFTPROMPT=$LEFTPROMPT" ["$BRANCH"]"
    fi

    LineEnding="\n"

    [ ${#LEFT_PROMPT}  -lt 30 ] && LineEnding=" "

    if [ $EUID -ne 0 ]; then
	PS1=$LEFTPROMPT"\[$Cyan\] "$NonRootPrompt"\[$NoColor\]"$LineEnding
    else
	PS1=$LEFTPROMPT"\[$Red\] "$RootPrompt$LineEnding
    fi

# echo -e -n $LEFTPROMPT
}

# Define PROMPT_COMMAND if not already defined (fix: Modifying title on SSH connections)
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

# Main prompt
PROMPT_COMMAND="prompt;$PROMPT_COMMAND"

if [ $EUID -ne 0 ]; then
    PS1=$NonRootPrompt" "
else
    PS1=$RootPrompt" "
fi


#[ -f /etc/profile.d/rvm.sh ] && . /etc/profile.d/rvm.sh && rvm use ruby > /dev/null


export PATH=/bin:/sbin:/usr/bin:/usr/sbin
