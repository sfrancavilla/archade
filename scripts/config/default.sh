#!/bin/bash

# This script uses 'stow' to manage dotfiles. It is designed to be run
# from any directory by dynamically finding its own location.

set -eo pipefail

echo "--- Stowing dotfiles ---"

# --- 1. ENSURE STOW IS INSTALLED ---
if ! command -v stow &> /dev/null; then
    echo "--- 'stow' not found. Installing now... ---"
    sudo pacman -S --noconfirm --needed stow
    echo "--- 'stow' installation complete ---"
fi

# --- 2. DEFINE DIRECTORIES RELATIVE TO THE SCRIPT'S LOCATION ---
# Get the absolute path of the directory where this script is located.
# BASH_SOURCE[0] is a variable that contains the path to the script itself.
# 'dirname' gets the directory part of that path.
# 'cd ... && pwd' resolves it to a full, absolute path.
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# The dotfiles directory is located two levels up from this script's directory.
# (From 'scripts/install/' up to 'scripts/' and then up to the project root)
# The packages to be stowed are inside this directory.
DOTFILES_DIR="$SCRIPT_DIR/../../dotfiles"

# The target directory for the symlinks is the user's home directory.
TARGET_DIR=~

# --- 3. STOW THE DOTFILES ---
# List of directories inside DOTFILES_DIR to stow
DIRECTORIES=(
    hyprland
    waybar
    kitty
    starship
    zsh
    fastfetch
    wofi
)

# Stow the directories
for dir in "${DIRECTORIES[@]}"; do
    if [ -d "$DOTFILES_DIR/$dir" ]; then
        echo "--- Stowing $dir ---"
        # -D unstows first, -S stows. This ensures a clean re-link.
        # --dir specifies where to find the packages to stow from.
        # -t specifies the target directory for the symlinks.
        stow -D "$dir" -t "$TARGET_DIR" --dir="$DOTFILES_DIR"
        stow -S "$dir" -t "$TARGET_DIR" --dir="$DOTFILES_DIR"
    else
        echo "--- WARNING: Directory '$dir' not found in '$DOTFILES_DIR', skipping. ---"
    fi
done

echo "--- Dotfile management complete ---"
