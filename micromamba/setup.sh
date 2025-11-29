#! /bin/bash

micromamba create -n dev

micromamba activate dev

micromamba install --file micromamba_env.txt

ln -s $CONDA_PREFIX/lib/libtbb.so.12 $CONDA_PREFIX/lib/libtbb.so
