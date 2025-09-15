#!/bin/bash

# The script manages the theme switching for the Archade desktop environment.
# It manages a single symlink for composable configs (Hyprland, Kitty)
# and handles full-file swaps for others (Starship).

# --- CONFIGURATION ---
THEMES_DIR="$HOME/archade/themes"
THEMER_DIR="$HOME/.config/themer"
CURRENT_THEME_LINK="$THEMER_DIR/theme"

# Apps that use the "base + partial" model via the central symlink.
APPS_USING_PARTIALS=(
    hypr
    kitty
    waybar
    mako
)

# Apps that require a full config file swap.
APPS_WITH_FULL_CONFIG=(
    starship
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
echo "  -> Central theme link updated for partial-based apps."

# --- Part B: Full Config Swap for Starship ---
for app in "${APPS_WITH_FULL_CONFIG[@]}"; do
    source_file="$THEME_PATH/${app}.toml"
    dest_file="$HOME/.config/${app}.toml"

    if [ -f "$source_file" ]; then
        echo "  -> Swapping full config for '$app'..."
        # Create a symlink from ~/.config/starship.toml to the theme's version
        ln -snf "$source_file" "$dest_file"
    fi
done


# 3. RELOAD APPLICATIONS
echo "Reloading applications to apply the new theme..."
hyprctl reload
echo "  -> Hyprland reloaded."

killall -SIGUSR2 waybar
echo "  -> Waybar reloaded."

pkill -USR1 kitty
echo "  -> Kitty instances signaled to reload."

makoctl reload
echo "  -> Mako reloaded."

echo "  -> Starship will update on the next prompt."

echo ""
echo "Theme switch to '$SELECTED_THEME' complete!"