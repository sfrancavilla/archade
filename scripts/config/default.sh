#!/bin/bash

# This script handles configurations that belong in ~/.config/ and those in the home directory.
# It is designed to be non-interactive, automatically backing up any existing configurations.

# --- DEFINE DIRECTORIES ---
DEFAULT_DIR=$HOME/archade/default
TARGET_DIR=$HOME

# --- LIST OF CONFIGS TO INSTALL ---

# These configurations will be placed inside the ~/.config/ directory.
CONFIGS_IN_CONFIG_DIR=(
    fastfetch
    hypr
    kitty
    starship
    waybar
    wofi
)

# These are traditional dotfiles that belong directly in the home directory (~/).
CONFIGS_IN_HOME_DIR=(
    zsh
)

# --- FUNCTION TO HANDLE THE LINKING LOGIC ---
# This version is fully automated. If a file exists, it is backed up
# with a timestamp, and then the new symlink is created.
link_file() {
    local source_file=$1
    local dest_file=$2

    # Ensure the destination directory exists before we do anything.
    mkdir -p "$(dirname "$dest_file")"

    # Check for conflicts (if a file, directory, or symlink already exists).
    # The '-e' flag checks for general existence.
    if [ -e "$dest_file" ]; then
        # Create a unique backup name with a timestamp.
        local backup_name="${dest_file}.bak.$(date +%Y%m%d-%H%M%S)"
        echo "  -> INFO: Existing file found at '$dest_file'."
        echo "     Backing it up to '$backup_name'"
        # Move the existing file to the backup location.
        mv "$dest_file" "$backup_name"
    fi

    # Now that the path is clear, create the new symlink.
    echo "  -> Linking '$source_file' to '$dest_file'"
    ln -sv "$source_file" "$dest_file"
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
    find "$DEFAULT_DIR/$config" -type f | while read -r source_file; do
        dest_file="$TARGET_DIR/$(basename "$source_file")"
        link_file "$source_file" "$dest_file"
    done
done

echo ""
echo "Installation complete!"
echo "You may need to restart your shell or log out for all changes to take effect."

