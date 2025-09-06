#!/bin/bash

# Directory containing your wallpapers
WALLPAPER_DIR="$HOME/archade/wallpapers"

# Check if directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    exit 1
fi

# Select a random wallpaper
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.bmp" -o -name "*.gif" \) | shuf -n 1)

if [ -z "$RANDOM_WALLPAPER" ]; then
    exit 1
fi

# Set the wallpaper with a transition
swww img "$RANDOM_WALLPAPER" --transition-type wipe --transition-angle 30 --transition-step 90 >/dev/null 2>&1
