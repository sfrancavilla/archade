#!/bin/bash

# Install basic fonts and icon fonts.

# Stop on any error
set -eo pipefail

# --- 1. INSTALL SYSTEM FONTS ---
echo "--- Installing Noto fonts from official repositories... ---"
sudo pacman -Syu --noconfirm --needed noto-fonts noto-fonts-cjk noto-fonts-emoji

# --- 2. INSTALL NERD FONTS FROM SOURCE ---
echo "--- Installing Nerd Fonts from source... ---"
# Navigate to a temporary directory
cd /tmp

# Clone the official Nerd Fonts repository
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts

# Install both fonts with a single command
./install.sh CascadiaCode NerdFontsSymbolsOnly

# Clean up the temporary directory
cd ..
rm -rf nerd-fonts

echo "--- Fonts installation complete! ---"