#!/bin/bash

# Install Hyprland core dependencies.

# Stop on any error
set -eo pipefail

# --- 1. INSTALL HYPRLAND AND CORE COMPONENTS ---
echo "--- Installing Hyprland and essential components... ---"

# List of packages to install via yay
PACKAGES=(
    # Core
    hyprland
    hyprland-qtutils
    hyprpolkitagent # Hyprland polkit agent
    mako          # Notification daemon
    pipewire      # Audio server
    qt5-wayland qt6-wayland # For app compatibility
    wireplumber   # Session manager for PipeWire
    xdg-desktop-portal-hyprland # Desktop portal for Hyprland
    # Utilities
    blueberry    # Bluetooth manager
    cliphist     # Clipboard history
    fastfetch    # System info
    hyprpaper    # Wallpaper manager
    hyprpicker   # Color picker
    kitty        # Terminal
    nautilus     # File manager
    starship     # Prompt
    waybar       # Status bar
    wofi         # Application launcher
)

# Install all the packages
pacman -S --noconfirm ${PACKAGES[@]}

echo "--- Desktop Environment installation complete! ---"