#!/bin/bash

# This script handles configurations that belong in ~/.config/ and those in the home directory.

# --- DEFINE DIRECTORIES ---
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
DEFAULT_DIR="$SCRIPT_DIR/../../default"

# Define the target, which is the user's home directory.
TARGET_DIR=~

# --- LIST OF CONFIGS TO INSTALL ---

# These configurations will be placed inside the ~/.config/ directory.
# The script will create subdirectories matching these names.
CONFIGS_IN_CONFIG_DIR=(
    fastfetch
    hypr
    kitty
    starship
    waybar
    wofi
)

# These are traditional dotfiles that belong directly in the home directory (~/).
# The source directory name (e.g., 'zsh') will be mapped to the target
# file name (e.g., '.zshrc').
CONFIGS_IN_HOME_DIR=(
    zsh
)


# --- FUNCTION TO HANDLE THE LINKING LOGIC ---
# This reusable function avoids repeating the same code in both loops.
link_file() {
    local source_file=$1
    local dest_file=$2

    # Ensure the destination directory exists before we do anything.
    # The '-p' flag is crucial as it creates parent directories if needed
    # and doesn't error if the directory already exists.
    mkdir -p "$(dirname "$dest_file")"

    # Check for conflicts (if a file or symlink already exists at the destination).
    if [ -f "$dest_file" ] || [ -L "$dest_file" ]; then
        echo "  -> WARNING: '$(basename "$dest_file")' already exists."
        read -p "     Do you want to overwrite it? [y/N] " response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
            echo "     Backing up to ${dest_file}.bak"
            mv "$dest_file" "${dest_file}.bak"
            echo "     Creating new symlink..."
            ln -sv "$source_file" "$dest_file"
        else
            echo "     Skipping '$(basename "$dest_file")'."
        fi
    else
        # No conflict, just create the symlink.
        echo "  -> Linking '$(basename "$dest_file")'..."
        ln -sv "$source_file" "$dest_file"
    fi
}

# --- MAIN INSTALLATION LOOPS ---

echo ""
echo "--- Installing configurations for ~/.config/ ---"
for config in "${CONFIGS_IN_CONFIG_DIR[@]}"; do
    echo "Processing '$config'..."
    # Find all files in the source and link them to ~/.config/<name>/...
    find "$DEFAULT_DIR/$config" -type f | while read -r source_file; do
        relative_path="${source_file#$DEFAULT_DIR/$config/}"
        dest_file="$TARGET_DIR/.config/$config/$relative_path"
        link_file "$source_file" "$dest_file"
    done
done

echo ""
echo "--- Installing configurations for ~/ ---"
for config in "${CONFIGS_IN_HOME_DIR[@]}"; do
    echo "Processing '$config'..."
    # This loop assumes the file in the source dir (e.g., 'zshrc') should be
    # named with a dot prefix in the destination (e.g., '.zshrc').
    find "$DEFAULT_DIR/$config" -type f | while read -r source_file; do
        dest_file="$TARGET_DIR/.$(basename "$source_file")"
        link_file "$source_file" "$dest_file"
    done
done

echo ""
echo "Installation complete!"
echo "You may need to restart your shell or log out for all changes to take effect."
