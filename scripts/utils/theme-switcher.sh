#!/bin/bash

# Switch the entire desktop theme, inspired by Omarchy.
# It manages a single symlink and reloads all relevant applications.

# --- CONFIGURATION ---
THEMES_DIR="$HOME/archade/themes"
THEMER_DIR="$HOME/.config/themer"
CURRENT_THEME_LINK="$THEMER_DIR/theme" # This is the single, central symlink

# --- SCRIPT LOGIC ---
SELECTED_THEME=$1

# 1. VALIDATION
if [ -z "$SELECTED_THEME" ]; then
    echo "Usage: $0 <theme_name>" >&2
    echo "Available themes:" >&2
    ls -1 "$THEMES_DIR"
    exit 1
fi

THEME_PATH="$THEMES_DIR/$SELECTED_THEME"
if [ ! -d "$THEME_PATH" ]; then
    echo "ERROR: Theme '$SELECTED_THEME' does not exist." >&2
    exit 2
fi

# 2. THEME SWITCHING (THE CORE LOGIC)
echo "Switching to theme: $SELECTED_THEME"
# Create the base directory if it doesn't exist
mkdir -p "$THEMER_DIR"
# Update the single, central symlink to point to the new theme directory.
ln -snf "$THEME_PATH" "$CURRENT_THEME_LINK"
echo "  -> Central theme link updated."

echo ""
echo "Theme switch to '$SELECTED_THEME' complete!"

