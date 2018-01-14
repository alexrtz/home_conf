if [ -f ~/.bash_completion.d/mercurial ]; then
  . ~/.bash_completion.d/mercurial
fi

hg_ps1() {
    hg prompt "{ on {branch}}{ at {bookmark}}{status}" 2> /dev/null
}

export PS1='\u at \h in \w$(hg_ps1)\n$ '
