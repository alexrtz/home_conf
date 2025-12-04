EDITOR="emacs -nw -q"
SHELL_USERNAME=alex

NPM_PACKAGES_DIR=~/Documents/Programs/root/usr/npm_packages

PATH=~/.config/mine/git/git.d/git-number:$HOME/.local/bin:$PATH:$HOME/Documents/Programs/root/usr/bin:~/.cargo/bin:$NPM_PACKAGES_DIR/bin:/usr/local/bin
export PATH=$HOME/Documents/Programs/root/usr/bin:$PATH

PKG_CONFIG_PATH=$MY_PKG_CONFIG_PATH:/home/alex/Documents/Programs/root/usr/lib/pkgconfig:$PKG_CONFIG_PATH

export QT_SELECT=5

export PATH
export LD_LIBRARY_PATH
export PKG_CONFIG_PATH

export WFICA_OPTS="-span a"

export CMAKE_GENERATOR=Ninja

# To fix the claude install script with encrypted filesystems
export BUN_CONFIG_DISABLE_COPY_FILE_RANGE=true
