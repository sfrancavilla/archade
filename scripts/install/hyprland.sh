#!/bin/bash

# Install Hyprland by compiling it from source.

# Stop on any error
set -eo pipefail

# --- 1. INSTALL DEPENDENCIES ---
# These are the build tools and libraries Hyprland needs to compile.
# They are all available in the official Arch repositories.
echo "--- Installing build tools and Hyprland dependencies ---"
sudo pacman -Syu --noconfirm --needed \
    git base-devel cmake ninja gcc \
    wayland-protocols libdisplay-info libliftoff \
    libinput libxkbcommon pango cairo udisks2 tomlplusplus

# --- 2. BUILD AND INSTALL HYPRLAND ---
echo "--- Cloning and building Hyprland from source ---"

# We'll build it in a temporary directory
pushd /tmp

# Clone the Hyprland repository
# The --recursive flag is important as it pulls in necessary submodules
git clone --recursive https://github.com/hyprwm/Hyprland

# Enter the newly created directory
cd Hyprland

# Compile the source code and install it to the system
make all && sudo make install

# Go back to the original directory
popd

echo "--- Hyprland has been successfully installed! ---"