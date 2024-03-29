EDITOR="emacs -nw -q"
SHELL_USERNAME=alex

PATH=~/.config/mine/git/git.d/git-number:$HOME/.local/bin:$PATH:/usr/local/bin

if [ -n "$MY_PATH" ];
then
    PATH=$MY_PATH:$PATH
fi

LD_LIBRARY_PATH=/usr/lib:/usr/local/lib

if [ -n "$MY_LD_LIBRARY_PATH" ];
then
    LD_LIBRARY_PATH=$MY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH
fi

if [ -n "$MY_LIBRARY_PATH" ];
then
    LIBRARY_PATH=$MY_LIBRARY_PATH:$LIBRARY_PATH
fi

PKG_CONFIG_PATH=$MY_PKG_CONFIG_PATH:/home/alex/Documents/Programs/root/usr/lib/pkgconfig:$PKG_CONFIG_PATH

export QT_SELECT=5

export PATH
export LD_LIBRARY_PATH
export PKG_CONFIG_PATH

export WFICA_OPTS="-span a"

export JAVA_HOME=$(readlink -f $(which java) | sed 's:bin/java::')
export HADOOP_HOME=/opt/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

export SPARK_HOME=/opt/spark
export PATH=$PATH:$SPARK_HOME/bin
export SPARK_LOCAL_IP=127.0.0.1

export CMAKE_GENERATOR=Ninja
