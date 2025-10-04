#!/bin/bash

# This script performs the initial, one-time setup.
# It correctly handles three types of configurations:
# 1. XDG Directories (~/.config/app/)
# 2. XDG Files      (~/.config/app.toml, ~/.config/app.conf, etc.)
# 3. Home Dotfiles  (~/.bashrc)

echo "Starting initial dotfiles setup..."

# --- DEFINE DIRECTORIES ---
BASE_CONFIG_DIR="$HOME/archade/base"
CONFIG_TARGET_DIR="$HOME/.config"
HOME_TARGET_DIR="$HOME"
THEME_SWITCHER_SCRIPT="$HOME/archade/scripts/utils/theme-switcher.sh"

# --- DEFINE CONFIGURATION LISTS ---

# Category 1: Apps with a config DIRECTORY in ~/.config/
XDG_DIRS=(
  hypr
  kitty
  waybar
  fastfetch
  wofi
  impala
  mako
)

# Category 2: Apps with a single config FILE in ~/.config/
# Use the FULL FILENAME to handle any extension.
XDG_FILES=(
  "starship.toml"
  # Example for another app: "btop.conf"
)

# Category 3: Apps with traditional dotfiles in ~/
HOME_DOTFILES=(
  bash
)

# --- 1. LINK XDG DIRECTORIES ---
echo ""
echo "--- Symlinking XDG Directories to ~/.config/ ---"
for app in "${XDG_DIRS[@]}"; do
  source_dir="$BASE_CONFIG_DIR/$app"
  dest_dir="$CONFIG_TARGET_DIR/$app"

  if [ -d "$source_dir" ]; then
    echo "  -> Linking directory for '$app'..."
    if [ -e "$dest_dir" ]; then
      mv "$dest_dir" "$dest_dir.bak.$(date +%Y%m%d-%H%M%S)"
    fi
    ln -s "$source_dir" "$dest_dir"
  fi
done

# --- 2. LINK XDG FILES ---
echo ""
echo "--- Symlinking XDG Files to ~/.config/ ---"
for config_file in "${XDG_FILES[@]}"; do
  source_file="$BASE_CONFIG_DIR/$config_file"
  dest_file="$CONFIG_TARGET_DIR/$config_file"

  if [ -f "$source_file" ]; then
    echo "  -> Linking file for '$config_file'..."
    if [ -e "$dest_file" ]; then
      mv "$dest_file" "$dest_file.bak.$(date +%Y%m%d-%H%M%S)"
    fi
    ln -s "$source_file" "$dest_file"
  else
    echo "  -> WARNING: Source file not found for '$config_file'. Skipping."
  fi
done

# --- 3. LINK HOME DOTFILES ---
echo ""
echo "--- Symlinking traditional dotfiles to ~/ ---"
for app in "${HOME_DOTFILES[@]}"; do
  source_dir="$BASE_CONFIG_DIR/$app"
  find "$source_dir" -type f | while read -r source_file; do
    dest_file="$HOME_TARGET_DIR/.$(basename "$source_file")"
    echo "  -> Linking dotfile for '$app'..."
    if [ -e "$dest_file" ]; then
      mv "$dest_file" "$dest_file.bak.$(date +%Y%m%d-%H%M%S)"
    fi
    ln -s "$source_file" "$dest_file"
  done
done

# --- 4. SET THE INITIAL THEME ---
echo ""
echo "--- Setting the initial 'default' theme... ---"
if [ -f "$THEME_SWITCHER_SCRIPT" ]; then
  bash "$THEME_SWITCHER_SCRIPT" default
else
  echo "ERROR: Theme switcher not found!" >&2
  exit 1
fi

echo ""
echo "Initial setup complete!"
