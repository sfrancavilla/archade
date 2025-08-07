#!/bin/bash

# Stop on any error
set -eo pipefail

# This line ensures stow is installed before we try to use it.
echo "--- Installing stow for dotfile management ---"
sudo pacman -S --noconfirm --needed stow

echo "--- Stowing dotfiles ---"

# This script should be run from the root of the Archade directory.
DOTFILES_DIR="dotfiles"

# List of packages/configs to stow.
PACKAGES=(
    hyprland
    waybar
    kitty
)

# Stow each package.
for package in ${PACKAGES[@]}; do
    echo "Stowing ${package}..."
    stow -D ${package} -t ~ --dir=${DOTFILES_DIR}
    stow -S ${package} -t ~ --dir=${DOTFILES_DIR}
done

echo "--- Dotfiles have been stowed successfully! ---"