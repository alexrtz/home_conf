# /etc/skel/.bashrc:
# $Header: /home/cvsroot/gentoo-src/rc-scripts/etc/skel/.bashrc,v 1.8 2003/02/28 15:45:35 azarah Exp $

# This file is sourced by all *interactive* bash shells on startup.  This
# file *should generate no output* or it will break the scp and rcp commands.

export SSH_AUTH_SOCK=0

HISTFILE=~/.bash_history
HISTSIZE=2048
HISTFILESIZE=1048576
HISTCONTROL=ignoredups

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f ~/.bash_completion/ctest ]; then
    . ~/.bash_completion/ctest
fi

if [ -f /etc/bash_completion.d/git ]; then
    . /etc/bash_completion.d/git
     complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
-        || complete -o default -o nospace -F _git g
fi



EDITOR=emacs

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


# alias gitarch="git archive master --format=tar --prefix=`pwd | sed -e 's/\// /g' |awk '{print $NF}'`/ | gzip >`pwd | sed -e 's/\// /g' |awk '{print $NF}'`.tgz"


if [ -f ~/.bash_specific_config ]; then
   . ~/.bash_specific_config
fi

PATH=$MYPATH:/usr/sbin:/var/lib/gems/1.8/bin/:/opt/usr/bin:$PATH
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:/usr/local/lib

export PATH
export LD_LIBRARY_PATH

[ -s "/users/alexorti/.scm_breeze/scm_breeze.sh" ] && source "/users/alexorti/.scm_breeze/scm_breeze.sh"
