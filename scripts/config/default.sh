#!/bin/bash

# This script uses 'stow' to manage dotfiles. It is designed to be run
# from any directory by dynamically finding its own location.
# This version uses the '--restow' flag for a more forceful application.

set -eo pipefail

echo "--- Stowing dotfiles ---"

# --- 1. ENSURE STOW IS INSTALLED ---
if ! command -v stow &> /dev/null; then
    echo "--- 'stow' not found. Installing now... ---"
    sudo pacman -Syu --noconfirm --needed stow
    echo "--- 'stow' installation complete ---"
fi

# --- 2. DEFINE DIRECTORIES RELATIVE TO THE SCRIPT'S LOCATION ---
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
DOTFILES_DIR="$SCRIPT_DIR/../../dotfiles"
TARGET_DIR=~

# --- 3. STOW THE DOTFILES ---
DIRECTORIES=(
    hyprland
    waybar
    kitty
    starship
    zsh
    fastfetch
    wofi
)

for dir in "${DIRECTORIES[@]}"; do
    if [ -d "$DOTFILES_DIR/$dir" ]; then
        echo "--- Restowing $dir ---"
        stow -R "$dir" -t "$TARGET_DIR" --dir="$DOTFILES_DIR"
    else
        echo "--- WARNING: Directory '$dir' not found in '$DOTFILES_DIR', skipping. ---"
    fi
done

echo "--- Dotfile management complete ---"

