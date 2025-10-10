#!/usr/bin/env bash

THEMER_DIR="$HOME/.config/themer"
CURRENT_THEME_LINK="$THEMER_DIR/theme"
WALLPAPER_DIR="$CURRENT_THEME_LINK/wallpapers/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

# Apply the selected wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"