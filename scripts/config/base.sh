#!/bin/bash

# This script performs the initial, one-time setup.
# It symlinks the BASE configurations and then sets the DEFAULT theme.

echo "Starting initial dotfiles setup..."

# --- DEFINE DIRECTORIES ---
BASE_CONFIG_DIR="$HOME/archade/base"
TARGET_DIR="$HOME/.config"
THEME_SWITCHER_SCRIPT="$HOME/archade/scripts/utils/theme-switcher.sh"

# --- 1. LINK BASE CONFIGURATIONS ---
echo "--- Symlinking BASE application configurations... ---"
# Loop through each app in the base directory (hypr, kitty, etc.)
for app in $(ls "$BASE_CONFIG_DIR"); do
    source_dir="$BASE_CONFIG_DIR/$app"
    dest_dir="$TARGET_DIR/$app"

    if [ -d "$source_dir" ]; then
        echo "  -> Linking base config for '$app'..."
        # Backup existing config if it exists
        if [ -e "$dest_dir" ]; then
            mv "$dest_dir" "$dest_dir.bak.$(date +%Y%m%d-%H%M%S)"
        fi
        # Create the symlink
        ln -s "$source_dir" "$dest_dir"
    fi
done

# --- 2. SET THE INITIAL THEME ---
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

