alias h="history"

alias l="ls --color=auto"
alias ls="ls --color=auto"
alias ll="ls --color -l"

alias rm="rm -i"

alias u=uncompress_file

alias bi="b install"

alias dpump="pump make -j 6"

alias cmkae="cmake"
alias cmaek="cmake"
alias cmb="cmake . -B build"
alias dcmake="rm -f CMakeCache.txt; cmake .. -DCMAKE_C_COMPILER=/usr/lib/distcc/gcc -DCMAKE_CXX_COMPILER=/usr/lib/distcc/g++"
alias cmaker="rm -f CMakeCache.txt; cmake .. -DCMAKE_BUILD_TYPE:STRING=release"
alias dcmaker="rm -f CMakeCache.txt; cmake .. -DCMAKE_C_COMPILER=/usr/lib/distcc/gcc -DCMAKE_CXX_COMPILER=/usr/lib/distcc/g++ -DCMAKE_BUILD_TYPE:STRING=release"

alias grpe="grep"
alias mysqldump="mysqldump --opt -e -B"

alias bc="bc -l"

alias dfr="df -Ph | grep LOCAL | cut -d' ' -f '9'"

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
which ack > /dev/null 2>&1 || ACK=ack-grep
alias ack="$ACK --smart-case -s"
alias ackcpp="$ACK --cpp"

alias agcpp="ag --cpp"

alias t=tmuxinator

alias show_upgrades="apt-get -s upgrade| awk -F'[][() ]+' '/^Inst/{printf \"Prog: %s\tcur: %s\tavail: %s\n\", \$2,\$3,\$4}'"

alias dpi=docker_purge_images
alias dpc=docker_purge_containers

alias killsshagent="killall ssh-agent; rm -f ~/.ssh/sock"

alias yt="yt-dlp -o \"%(upload_date)s_%(title)s\""
