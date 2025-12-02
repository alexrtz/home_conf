#!/bin/bash

set -e  # Exit on error

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Parsing package list from micromamba_env.txt..."

# Parse micromamba_env.txt to extract package specifications
# Skip header lines, virtual packages (starting with _), and extract package specs from conda-forge
# Use only name=version (without build) to let micromamba resolve compatible builds
CONDA_PACKAGES=$(awk '
    NR > 4 && $4 == "conda-forge" && $1 !~ /^_/ {
        printf "%s=%s ", $1, $2
    }
' "${SCRIPT_DIR}/micromamba_env.txt")

# Extract PyPI packages for separate installation
PYPI_PACKAGES=$(awk '
    NR > 4 && $4 == "pypi" {
        printf "%s==%s ", $1, $2
    }
' "${SCRIPT_DIR}/micromamba_env.txt")

echo "Creating micromamba environment 'dev'..."

# Create the environment with conda-forge packages
if [ -n "$CONDA_PACKAGES" ]; then
    micromamba create -n dev $CONDA_PACKAGES --yes
else
    micromamba create -n dev --yes
fi

echo "Environment 'dev' created successfully!"

# Initialize micromamba for this shell session
eval "$(micromamba shell hook --shell bash)"

# Activate the environment
micromamba activate dev

# Install PyPI packages if any
if [ -n "$PYPI_PACKAGES" ]; then
    echo "Installing PyPI packages..."
    pip install $PYPI_PACKAGES
fi

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

echo ""
echo "Setup complete! To activate this environment in your shell, run:"
echo "  micromamba activate dev"
