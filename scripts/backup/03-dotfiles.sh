#!/bin/bash

set -eo pipefail

echo "--- Stowing dotfiles ---"

if ! command -v stow &> /dev/null; then
    echo "--- Stow not found. Installing now... ---"
    sudo pacman -Syu --noconfirm --needed stow
    echo "--- Stow installation complete ---"
fi

DOTFILES_DIR="dotfiles"

# List of directories to stow
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
    echo "--- Stowing $dir ---"
    stow -D ${dir} -t ~ --dir=${DOTFILES_DIR}
    stow -S ${dir} -t ~ --dir=${DOTFILES_DIR}
done

echo "--- Dotfile management complete ---"