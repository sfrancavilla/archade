#!/bin/bash

# This script performs the initial, one-time setup.
# It correctly handles both modern ~/.config (XDG) and traditional ~/ dotfiles.

echo "Starting initial dotfiles setup..."

# --- DEFINE DIRECTORIES ---
BASE_CONFIG_DIR="$HOME/archade/base"
CONFIG_TARGET_DIR="$HOME/.config"
HOME_TARGET_DIR="$HOME"
THEME_SWITCHER_SCRIPT="$HOME/archade/scripts/utils/theme-switcher.sh"

# --- DEFINE CONFIGURATION LISTS ---

# List of apps that follow the XDG standard (live in ~/.config/)
XDG_CONFIGS=(
    hypr
    kitty
    waybar
    fastfetch
    wofi
)

# List of apps with traditional dotfiles (live in ~/)
HOME_DOTFILES=(
    bash
    zsh
    git
)

# --- 1. LINK BASE XDG CONFIGURATIONS ---
echo ""
echo "--- Symlinking BASE configurations to ~/.config/ ---"
for app in "${XDG_CONFIGS[@]}"; do
    source_dir="$BASE_CONFIG_DIR/$app"
    dest_dir="$CONFIG_TARGET_DIR/$app"

    if [ -d "$source_dir" ]; then
        echo "  -> Linking base config for '$app'..."
        if [ -e "$dest_dir" ]; then
            mv "$dest_dir" "$dest_dir.bak.$(date +%Y%m%d-%H%M%S)"
        fi
        ln -s "$source_dir" "$dest_dir"
    fi
done

# --- 2. LINK BASE HOME DOTFILES ---
echo ""
echo "--- Symlinking traditional dotfiles to ~/ ---"
for app in "${HOME_DOTFILES[@]}"; do
    source_dir="$BASE_CONFIG_DIR/$app"
    
    # We find each file inside the source dir (e.g., base/bash/bashrc)
    # and link it to the home dir with a dot prefix (e.g., ~/.bashrc)
    find "$source_dir" -type f | while read -r source_file; do
        # Use 'basename' to get just the filename (e.g., 'bashrc')
        # Prepend a dot to create the correct destination name (e.g., '.bashrc')
        dest_file="$HOME_TARGET_DIR/$(basename "$source_file")"

        echo "  -> Linking dotfile for '$app'..."
        if [ -e "$dest_file" ]; then
            mv "$dest_file" "$dest_file.bak.$(date +%Y%m%d-%H%M%S)"
        fi
        ln -s "$source_file" "$dest_file"
    done
done


# --- 3. SET THE INITIAL THEME ---
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

