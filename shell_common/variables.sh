EDITOR="emacs -nw -q"
SHELL_USERNAME=alex

NPM_PACKAGES_DIR=$HOME/Documents/Programs/root/usr/npm_packages

export GOPATH=$HOME/Documents/Programs/root/go

export ANDROID_SDK_ROOT=$HOME/Documents/Programs/android-sdk
ANDROID_SDK_CMD_LINE_TOOLS_BINARIES_PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
ANDROID_SDK_PLATFORM_TOOLS=$ANDROID_SDK_ROOT/platform-tools
PATH=$PATH:$ANDROID_SDK_ROOT/emulator


ANDROID_SDK_VERSION=36
ANDROID_NDK_VERSION=29.0.14206865
export ANDROID_NDK_ROOT=$HOME/Documents/Programs/android-sdk/ndk/$ANDROID_NDK_VERSION

export QT_ROOT=$HOME/Documents/Programs/Qt

export QT_ANDROID_KEYSTORE_PATH="$HOME/.android/debug.keystore"
export QT_ANDROID_KEYSTORE_ALIAS="androiddebugkey"

PATH=~/.config/mine/git/git.d/git-number:$HOME/.local/bin:$PATH:$HOME/Documents/Programs/root/usr/bin:$GOPATH/bin:~/.cargo/bin:$NPM_PACKAGES_DIR/bin:/usr/local/bin
PATH=$ANDROID_SDK_CMD_LINE_TOOLS_BINARIES_PATH:$ANDROID_SDK_PLATFORM_TOOLS:$PATH

PKG_CONFIG_PATH=$MY_PKG_CONFIG_PATH:$HOME/Documents/Programs/root/usr/lib/pkgconfig:$PKG_CONFIG_PATH

export QT_SELECT=5

export LD_LIBRARY_PATH
export PKG_CONFIG_PATH

export WFICA_OPTS="-span a"

export CMAKE_GENERATOR=Ninja

# To fix the claude install script with encrypted filesystems
export BUN_CONFIG_DISABLE_COPY_FILE_RANGE=true
