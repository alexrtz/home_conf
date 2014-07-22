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
alias gsr="git svn rebase"
alias v=vim

NB_PROCS=`cat /proc/cpuinfo|grep 'processor'|wc -l`

# Made some tests on a machine with 16 cores and with -j10 and higher the compilation was slower
# than with -j9
# It could go faster with an SSD but I keep using the 'safe' value until I can test with an SSD
# and more than 10 cores.
[ ${NB_PROCS} -lt 9 ] || NB_PROC=8

NB_PROCS=$((${NB_PROCS} + 1))

alias m="make -j${NB_PROCS}"

alias killsshagent="killall ssh-agent; rm -f ~/.ssh/sock"
