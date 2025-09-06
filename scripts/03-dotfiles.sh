#!/bin/bash

set -eo pipefail

echo "--- Installing stow for dotfile management ---"
sudo pacman -S --noconfirm --needed stow

echo "--- Stowing dotfiles ---"

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