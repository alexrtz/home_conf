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
alias p=python3
alias pg_data_dump="pg_dump -a bss |grep -v '^\(--\)\?$'|grep -v 'PostgreSQL database dump' | grep -v '^SET' | grep -v '^--Name' | grep -v '^SELECT'"
alias qm="qmake \"CONFIG += silent\" -r"

alias g="git"
alias ga="g a"
alias gci="g ci"
alias gco="g co"
alias gcp="g cp"
alias gll="g ll"
alias gnb="g nb"
alias gst="g st"
alias gsr="git svn rebase"

alias gk="gitk"


ACK=ack
which ack > /dev/null || ACK=ack-grep
alias ack="$ACK --smart-case -s"
alias ackcpp="$ACK --cpp"

alias t=tmuxinator

alias show_upgrades="apt-get -s upgrade| awk -F'[][() ]+' '/^Inst/{printf \"Prog: %s\tcur: %s\tavail: %s\n\", \$2,\$3,\$4}'"


alias dpi=docker_purge_images
alias dpc=docker_purge_containers


NB_PROCS=`nproc`

# Made some tests on a machine with 16 cores and with -j10 and higher the compilation was slower
# than with -j9.
# It could go faster with an SSD but I keep using the 'safe' value until I can test with an SSD
# and more than 10 cores.
[ ${NB_PROCS} -lt 9 ] || NB_PROC=8

NB_PROCS=$((${NB_PROCS} + 1))

alias m="make -j$NB_PROCS"

alias killsshagent="killall ssh-agent; rm -f ~/.ssh/sock"
