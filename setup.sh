#! /bin/bash

mkdir -p ~/tmp

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

# Create symlinks for each file/directory in dotfiles
for item in "$DOTFILES_DIR"/*
do
    if [ -e "$item" ]
		then
        filename=$(basename "$item")
        target="$HOME/.$filename"
        if [ ! -e "$target" ]
				then
            ln -s "$item" "$target"
            echo "Created symlink: $target -> $item"
        else
            echo "Skipping $filename (already exists)"
        fi
    fi
done

mkdir -p "$HOME/.config"

CONFIG_DIR="$SCRIPT_DIR/config"

for item in "$CONFIG_DIR"/*
do
    if [ -e "$item" ]
		then
        filename=$(basename "$item")
        target="$HOME/.config/$filename"
        if [ ! -e "$target" ]
				then
            ln -s "$item" "$target"
            echo "Created symlink: $target -> $item"
        else
            echo "Skipping $filename (already exists)"
        fi
    fi
done
