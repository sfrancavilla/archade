#!/bin/bash

# Install Hyprland core dependencies.

# Stop on any error
set -eo pipefail

# --- 1. INSTALL HYPRLAND AND CORE COMPONENTS ---
echo "--- Installing Hyprland and essential components... ---"

# List of packages to install via yay
PACKAGES=(
    # Core
    mako          # Notification daemon
    pipewire      # Audio server
    wireplumber   # Session manager for PipeWire
    xdg-desktop-portal-hyprland # Desktop portal for Hyprland
    hyprpolkitagent # Hyprland polkit agent
    qt5-wayland qt6-wayland # For app compatibility
    stow
    # Utilities
    waybar       # Status bar
    wofi         # Application launcher
    kitty        # Terminal
    zsh          # Shell
    starship     # Prompt
    hyprpaper    # Wallpaper manager
    hyprpicker   # Color picker
    cliphist     # Clipboard history
    nautilus     # File manager
    blueberry    # Bluetooth manager
)

# Use yay to install all the packages
pacman -Syu --noconfirm ${PACKAGES[@]}

echo "--- Desktop Environment installation complete! ---"