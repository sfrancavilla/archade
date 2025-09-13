#!/bin/bash

# Installer of default configurations

echo "It's time to install the default configurations!"
echo "This script will help you set up the default configurations safely."

# --- DEFINE DIRECTORIES ---
SCRIPTS_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
DEFAULT_DIR="$SCRIPTS_DIR/../../default"

# The user's home directory
TARGET_DIR=~

# --- LIST OF CONFIGS TO INSTALL ---
CONFIGS=(
    fastfetch
    hypr
    kitty
    starship
    waybar
    wofi
    zsh
)

# --- MAIN INSTALLATION LOOP ---
for config in "${CONFIGS[@]}"; do
    echo ""
    echo "Processing '$config' configuration..."
    
    # Use find to get a list of all files in the config directory.
    # This is more robust than just assuming the structure.
    SOURCE_FILES=$(find "$DEFAULT_DIR/$config" -type f)

    for source_file in $SOURCE_FILES; do
        # Create the relative path to determine the destination.
        relative_path="${source_file#$DEFAULT_DIR/$config/}"
        dest_file="$TARGET_DIR/.config/$relative_path"
        
        # Ensure the destination directory exists.
        mkdir -p "$(dirname "$dest_file")"

        # --- CHECK FOR CONFLICTS ---
        if [ -f "$dest_file" ] || [ -L "$dest_file" ]; then
            echo "  -> WARNING: '$relative_path' already exists."
            read -p "     Do you want to overwrite it? [y/N] " response
            if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
                # User said yes, so create a backup and then link.
                echo "     Backing up to ${dest_file}.bak"
                mv "$dest_file" "${dest_file}.bak"
                ln -sv "$source_file" "$dest_file"
            else
                echo "     Skipping '$relative_path'."
            fi
        else
            # No conflict, just create the symlink.
            ln -sv "$source_file" "$dest_file"
        fi
    done
done

echo ""
echo "Installation complete!"
echo "You may need to restart your shell or log out for all changes to take effect."

```

### Step 3: Write an Excellent README.md

This is the most critical step. Your `README.md` is the user manual.

It should include:
* **What is this?** A brief description of your setup (e.g., "My personal Hyprland setup on Arch Linux").
* **Prerequisites:** What software do they need before running your script? (`git`, `dialog` for popups, etc.).
* **How to Install:** Give them the exact, copy-pasteable commands.
    ```markdown
    ## Installation
    1. Clone the repository:
       ```bash
       git clone [https://github.com/your-username/dotfiles.git](https://github.com/your-username/dotfiles.git)
       ```
    2. Run the installer:
       ```bash
       cd dotfiles
       ./install.sh
       ```
    
