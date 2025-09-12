#!/bin/bash

# Install Hyprland by compiling it from source, ensuring proper cleanup.

# Stop on any error
set -eo pipefail

# --- 0. SETUP AND CLEANUP ---
# The 'mktemp -d' command creates a new directory in the specified location.
TMP_DIR=$(mktemp -d "$HOME/hyprland-build.XXXXXX")

# Define a cleanup function. This will be called when the script exits.
cleanup() {
  echo "--- Cleaning up temporary build directory: $TMP_DIR ---"
  # The 'rm -rf' command will forcefully remove the directory and all its contents.
  rm -rf "$TMP_DIR"
}

# Set a trap: The 'trap' command registers the 'cleanup' function to be
# executed whenever the script exits for any reason (EXIT), encounters an
# error (ERR), or is interrupted by the user (INT, TERM).
trap cleanup EXIT ERR INT TERM

# --- 1. INSTALL DEPENDENCIES ---
# These are the build tools and libraries Hyprland needs to compile.
# They are all available in the official Arch repositories.
echo "--- Installing build tools and Hyprland dependencies ---"
sudo pacman -Syu --noconfirm --needed \
    git base-devel cmake ninja gcc \
    wayland-protocols libdisplay-info libliftoff \
    libinput libxkbcommon pango cairo udisks2 tomlplusplus \
    acquamarine \

# --- 2. BUILD AND INSTALL HYPRLAND ---
echo "--- Cloning and building Hyprland from source ---"

# We'll build inside our secure temporary directory.
# 'pushd' changes the directory and saves the old one to a stack.
pushd "$TMP_DIR"

# Clone the Hyprland repository into the current directory (.)
# The --recursive flag is important as it pulls in necessary submodules.
git clone --recursive https://github.com/hyprwm/Hyprland .

# With 'git clone ... .', the repository contents are placed directly
# into the current directory, so we don't need to 'cd' into a subfolder.
# Compile the source code and install it to the system.
make all && sudo make install

# Go back to the original directory.
popd

echo "--- Hyprland has been successfully installed! ---"
# The 'cleanup' function will now be called automatically by the trap.

