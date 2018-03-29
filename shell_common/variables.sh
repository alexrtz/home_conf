EDITOR="emacs -nw -q"
SHELL_USERNAME=alex

PATH=~/.config/mine/git/git.d/git-number:$PATH:/usr/local/bin

if [ -n "$MY_PATH" ];
then
    PATH=$MY_PATH:$PATH
fi

LD_LIBRARY_PATH=/usr/lib:/usr/local/lib:$LD_LIBRARY_PATH

if [ -n "$LD_LIBRARY_PATH" ];
then
    LD_LIBRARY_PATH=$MY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH
fi

LD_LIBRARY_PATH=$MY_LD_LIBRARY_PATH:/usr/lib:/usr/local/lib:$LD_LIBRARY_PATH
LIBRARY_PATH=$MY_LIBRARY_PATH:/usr/lib:/usr/local/lib:$LIBRARY_PATH
PKG_CONFIG_PATH=$MY_PKG_CONFIG_PATH

export QT_SELECT=5

export PATH
export LD_LIBRARY_PATH
export PKG_CONFIG_PATH
