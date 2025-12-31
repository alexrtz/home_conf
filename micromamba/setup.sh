#!/bin/bash

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ENV_NAME=dev

echo "Creating micromamba environment '$ENV_NAME'..."

micromamba create -n $ENV_NAME --file environment.yml --yes

echo "Environment '$ENV_NAME' created successfully!"

# Initialize micromamba for this shell session
eval "$(micromamba shell hook --shell bash)"

# Activate the environment
micromamba activate $ENV_NAME

# Create symlink for libtbb if it doesn't exist
if [ -f "${CONDA_PREFIX}/lib/libtbb.so.12" ] && [ ! -f "${CONDA_PREFIX}/lib/libtbb.so" ]; then
    echo "Creating libtbb.so symlink..."
    ln -s "${CONDA_PREFIX}/lib/libtbb.so.12" "${CONDA_PREFIX}/lib/libtbb.so"
    echo "Symlink created successfully!"
elif [ -f "${CONDA_PREFIX}/lib/libtbb.so" ]; then
    echo "libtbb.so symlink already exists."
else
    echo "Warning: libtbb.so.12 not found in ${CONDA_PREFIX}/lib/"
fi

# Python and go, maybe this should be moved elsewhere

pip install -r requirements.txt

go install github.com/google/pprof@latest

echo ""
echo "Setup complete! To activate this environment in your shell, run:"
echo "  micromamba activate $ENV_NAME"
