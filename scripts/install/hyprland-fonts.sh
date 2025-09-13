#!/bin/bash

# Install basic system fonts and patched Nerd Fonts, ensuring proper cleanup.

# Stop on any error
set -eo pipefail

# --- 0. INSTALL SYSTEM FONTS ---
echo "--- Installing Noto fonts from official repositories... ---"
sudo pacman -S --noconfirm --needed noto-fonts noto-fonts-cjk noto-fonts-emoji

echo "--- Starting local font installation ---"
SOURCE_DIR="$HOME/archade/assets/local-fonts"

# Define the destination directories on the system.
# Fonts will be installed for the current user.
USER_FONT_DIR="$HOME/.local/share/fonts"
# Font configuration is system-wide and requires sudo.
SYSTEM_CONF_DIR="/etc/fonts/conf.d"

# --- 2. ENSURE DESTINATION DIRECTORIES EXIST ---
echo "--- Ensuring font directories exist... ---"
mkdir -p "$USER_FONT_DIR"

# --- 3. COPY FONT AND CONFIGURATION FILES ---
echo "--- Copying font files... ---"
# The -v flag makes 'cp' verbose, showing which files are being copied.
cp -v "$SOURCE_DIR/CascadiaCode/"* "$USER_FONT_DIR/"
cp -v "$SOURCE_DIR/Symbols-Only/"* "$USER_FONT_DIR/"

echo "--- Installing system-wide font configuration... ---"
# This requires sudo because it's a system directory.
sudo cp -v "$SOURCE_DIR/10-nerd-font-symbols.conf" "$SYSTEM_CONF_DIR/"

# --- 4. REBUILD THE FONT CACHE ---
# This is a critical step. It tells the system to re-scan all font
# directories and update its index of available fonts and rules.
echo "--- Rebuilding font cache (this may take a moment)... ---"
fc-cache -fv

echo "--- Fonts installation complete! ---"
