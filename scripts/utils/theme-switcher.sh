#!/bin/bash

# The script manages the theme switching for the Archade desktop environment.
# It handles both "base + partial" configs via a central symlink and
# full, self-contained configuration files.

# --- CONFIGURATION ---
THEMES_DIR="$HOME/archade/themes"
THEMER_DIR="$HOME/.config/themer"
CURRENT_THEME_LINK="$THEMER_DIR/theme"

# Apps that require a full config file swap.
# Use the FULL FILENAME to handle any extension.
FULL_CONFIG_FILES=(
    "starship.toml"
    # Example for another app: "btop.conf"
)

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

# 2. THEME SWITCHING

# --- Part A: Central Symlink for Partial-based Apps ---
echo "Switching to theme: $SELECTED_THEME"
mkdir -p "$THEMER_DIR"
ln -snf "$THEME_PATH" "$CURRENT_THEME_LINK"
echo "  -> Central theme link updated for all partial-based apps."

# --- Part B: Full Config Swap for self-contained configs ---
for config_file in "${FULL_CONFIG_FILES[@]}"; do
    source_file="$THEME_PATH/$config_file"
    dest_file="$HOME/.config/$config_file"

    if [ -f "$source_file" ]; then
        echo "  -> Swapping full config for '$config_file'..."
        # Create a symlink from ~/.config/starship.toml to the theme's version
        ln -snf "$source_file" "$dest_file"
    else
        echo "  -> NOTE: No config for '$config_file' found in theme '$SELECTED_THEME'. Skipping."
    fi
done


# 3. RELOAD APPLICATIONS
echo "Reloading applications to apply the new theme..."
hyprctl reload
echo "  -> Hyprland reloaded."

# Use a more robust way to find and signal waybar
if pgrep -x "waybar" > /dev/null; then
    killall -SIGUSR2 waybar
    echo "  -> Waybar reloaded."
fi

# Use a more robust way to find and signal kitty
if pgrep -x "kitty" > /dev/null; then
    pkill -USR1 kitty
    echo "  -> Kitty instances signaled to reload."
fi

# Use a more robust way to find and signal mako
if pgrep -x "mako" > /dev/null; then
    makoctl reload
    echo "  -> Mako reloaded."
fi

echo "  -> Starship will update on the next prompt."

echo ""
echo "Theme switch to '$SELECTED_THEME' complete!"

