
# Not sure why I put this in my previous config
#export SSH_AUTH_SOCK=0


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

