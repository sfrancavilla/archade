#!/bin/bash

# This script performs the initial, one-time setup.
# It correctly handles three types of configurations:
# 1. XDG Directories (~/.config/app/)
# 2. XDG Files      (~/.config/app.toml, ~/.config/app.conf, etc.)
# 3. Home Dotfiles  (~/.bashrc)
# 4. Local Share (~/.local/share)

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

# Category 4: Local Share (~/.local/share)
LOCAL_SHARE=(
  "applications"
)

link_configs() {
    local source_base="$1"
    local dest_base="$2"
    local -n items=$3

    for item in "${items[@]}"; do
        local source_path="$source_base/$item"
        local dest_path="$dest_base/$item"

        if [ -e "$source_path" ]; then
            echo "  -> Linking '$item'..."
            if [ -e "$dest_path" ]; then
                echo "     - Backing up existing config to ${dest_path}.bak"
                mv "$dest_path" "$dest_path.bak.$(date +%Y%m%d-%H%M%S)"
            fi
            ln -s "$source_path" "$dest_path"
        else
            echo "  -> WARNING: Source not found for '$item'. Skipping."
        fi
    done
}

# --- 1. LINK XDG DIRECTORIES ---
echo ""
echo "--- Symlinking XDG Directories to ~/.config/ ---"
link_configs "$BASE_CONFIG_DIR" "$CONFIG_TARGET_DIR" XDG_DIRS


# --- 2. LINK XDG FILES ---
echo ""
echo "--- Symlinking XDG Files to ~/.config/ ---"
link_configs "$BASE_CONFIG_DIR" "$CONFIG_TARGET_DIR" XDG_FILES

# --- 3. LINK HOME DOTFILES ---
echo ""
echo "--- Symlinking traditional dotfiles to ~/ ---"
link_configs "$BASE_CONFIG_DIR" "$HOME_TARGET_DIR" HOME_DOTFILES

# --- 4. LINK LOCAL SHARE ---
echo ""
echo "--- Symlinking local share to ~/.local/share/ ---"
link_configs "$BASE_CONFIG_DIR" "$HOME/.local/share" LOCAL_SHARE_DIRS

# --- 5. SET THE INITIAL THEME ---
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
