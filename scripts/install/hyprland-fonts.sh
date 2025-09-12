#!/bin/bash

# Install basic system fonts and patched Nerd Fonts, ensuring proper cleanup.

# Stop on any error
set -eo pipefail

# --- 0. SETUP AND CLEANUP ---
# Create a temporary directory in the user's home directory.
TMP_DIR=$(mktemp -d "$HOME/font-build.XXXXXX")

# Define a cleanup function. This will be called when the script exits.
cleanup() {
  echo "--- Cleaning up temporary font directory: $TMP_DIR ---"
  rm -rf "$TMP_DIR"
}

# Set a trap to run the cleanup function on exit, error, or interrupt.
trap cleanup EXIT ERR INT TERM

# --- 1. INSTALL SYSTEM FONTS ---
echo "--- Installing Noto fonts from official repositories... ---"
sudo pacman -S --noconfirm --needed noto-fonts noto-fonts-cjk noto-fonts-emoji

# --- 2. INSTALL NERD FONTS FROM SOURCE ---
echo "--- Installing Nerd Fonts from source... ---"

# Navigate into our temporary directory
pushd "$TMP_DIR"

# Clone the official Nerd Fonts repository
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts

# Install both fonts with a single command
./install.sh CascadiaCode NerdFontsSymbolsOnly

# Go back to the original directory
popd

echo "--- Fonts installation complete! ---"
# The 'cleanup' function will now be called automatically by the trap.
