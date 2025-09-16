#!/bin/bash

# Install Hyprland core dependencies.

# Stop on any error
set -eo pipefail

# --- 1. INSTALL HYPRLAND AND CORE COMPONENTS ---
echo "--- Installing Hyprland and essential components... ---"

# List of packages to install via pacman
PACKAGES=(
    # --- Core Desktop ---
    hyprland
    mako                                # Notification daemon
    qt5-wayland qt6-wayland             # For app compatibility
    waybar                              # Status bar
    xdg-desktop-portal-hyprland         # Desktop portal for Hyprland

    # --- Complete Audio Stack ---
    pipewire                            # The core audio server
    wireplumber                         # The session manager for PipeWire
    pipewire-pulse                      # PulseAudio compatibility layer (CRITICAL for most apps)
    pipewire-alsa                       # ALSA compatibility layer
    pipewire-jack                       # JACK compatibility layer (for pro-audio apps)

    # --- Utilities & Applications ---
    blueberry                           # Bluetooth manager
    cliphist                            # Clipboard history
    fastfetch                           # System info
    hyprpaper                           # Wallpaper manager
    hyprpicker                          # Color picker
    kitty                               # Terminal
    nautilus                            # File manager
    starship                            # Prompt
    wofi                                # Application launcher
)

# Install all the packages
sudo pacman -S --noconfirm --needed ${PACKAGES[@]}

echo "--- Desktop Environment installation complete! ---"

