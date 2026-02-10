SHELL_NAME=$(ps -p $$ -o comm=)

export MAMBA_EXE="$HOME/.local/mine/bin/micromamba";
export MAMBA_ROOT_PREFIX="$HOME/.local/mine/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell "$SHELL_NAME" --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"

if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
fi
unset __mamba_setup

micromamba env list | grep " dev " > /dev/null

if [ $? -eq 0 ]
then
		micromamba activate dev
		export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib/x86_64-linux-gnu/:$CONDA_PREFIX/lib
fi
