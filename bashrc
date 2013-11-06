# /etc/skel/.bashrc:
# $Header: /home/cvsroot/gentoo-src/rc-scripts/etc/skel/.bashrc,v 1.8 2003/02/28 15:45:35 azarah Exp $

# This file is sourced by all *interactive* bash shells on startup.  This
# file *should generate no output* or it will break the scp and rcp commands.

export SSH_AUTH_SOCK=0

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


EDITOR="emacs -nw -q"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

alias h="history"
alias l="ls --color=auto"
alias ls="ls --color=auto"
alias ll="ls --color -l"
alias rm="rm -i"
alias eamcs="emacs"
alias emasc="emacs"
alias make="make"
alias mkae="make"
alias maek="make"
alias cmkae="cmake"
alias cmaek="cmake"
alias grpe="grep"
alias mysqldump="mysqldump --opt -e -B"
alias bc="bc -l"
alias dfr="df -Ph | grep LOCAL | cut -d' ' -f '9'"
alias dpump="pump make -j 6"
alias dcmake="rm -f CMakeCache.txt; cmake . -DCMAKE_C_COMPILER=/usr/lib/distcc/gcc -DCMAKE_CXX_COMPILER=/usr/lib/distcc/g++"
alias cmaker="rm -f CMakeCache.txt; cmake . -DCMAKE_BUILD_TYPE:STRING=release"
alias dcmaker="rm -f CMakeCache.txt; cmake . -DCMAKE_C_COMPILER=/usr/lib/distcc/gcc -DCMAKE_CXX_COMPILER=/usr/lib/distcc/g++ -DCMAKE_BUILD_TYPE:STRING=release"
alias v="vim"
alias e="emacs"
alias g="git"
alias gk="gitk"
alias ackcpp="ack --cpp"
alias t=tmuxinator

# alias gitarch="git archive master --format=tar --prefix=`pwd | sed -e 's/\// /g' |awk '{print $NF}'`/ | gzip >`pwd | sed -e 's/\// /g' |awk '{print $NF}'`.tgz"


BASH_USERNAME=`whoami`

[ -f ~/.bash_specific_config ] && . ~/.bash_specific_config

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

    USERNAME=$BASH_USERNAME
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


PATH=$MYPATH:/usr/sbin:/var/lib/gems/1.8/bin/:/opt/usr/bin:$PATH
LD_LIBRARY_PATH=$MY_LD_LIBRARY_PATH:/usr/lib:/usr/local/lib:$LD_LIBRARY_PATH
LIBRARY_PATH=$MY_LIBRARY_PATH:/usr/lib:/usr/local/lib:$LIBRARY_PATH
PKG_CONFIG_PATH=$MY_PKG_CONFIG_PATH

export PATH
export LD_LIBRARY_PATH
export PKG_CONFIG_PATH

# On CentOS at work a dialog opens when git asks for a password.
# I do not like this behaviour and this line fixes it.
unset SSH_ASKPASS

if [ -f /usr/bin/ssh-agent ]; then
NB_AGENTS=`ps x | grep ssh-agent$ | wc -l`

    [ $NB_AGENTS -eq 0 ] && rm -f ~/.ssh/sock

    if [ ! -f ~/.ssh/sock ]; then
        killall ssh-agent &> /dev/null
        ssh-agent > ~/.ssh/tmp
        . ~/.ssh/tmp
        cat ~/.ssh/tmp | grep SOCK | cut -d'=' -f2 | cut -d';' -f1 > ~/.ssh/sock
        cat ~/.ssh/tmp | grep PID | cut -d'=' -f2 | cut -d';' -f1 > ~/.ssh/pid
        rm -f .ssh/tmp
        ssh-add ~/.ssh/id_rsa
    else
        SSH_AUTH_SOCK=`cat ~/.ssh/sock`
        export SSH_AUTH_SOCK
        SSH_AGENT_PID=`cat ~/.ssh/pid`
        export SSH_AGENT_PID
    fi
fi


alias killsshagent="killall ssh-agent; rm -f ~/.ssh/sock"

