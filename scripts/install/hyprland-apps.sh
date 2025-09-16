#!/bin/bash

# Install Hyprland core dependencies, handling potential conflicts.

# Stop on any error
set -eo pipefail

# --- 0. PRE-EMPTIVE CLEANUP ---
# Some packages might have pulled in 'jack2' as a dependency.
# 'pipewire-jack' provides the same functionality and conflicts with it.
# We explicitly remove the old package to prevent a conflict during the
# non-interactive installation.
echo "--- Removing potential conflicting audio packages... ---"
# The '-Rdd' flag is used to remove a package and ignore its dependencies,
# which is safe here because we are immediately installing a replacement.
sudo pacman -Rdd --noconfirm jack2 2>/dev/null || true


# --- 1. INSTALL HYPRLAND AND CORE COMPONENTS ---
echo "--- Installing Hyprland and essential components... ---"

# List of packages to install via pacman
PACKAGES=(
    # --- Core Desktop ---
    hyprland
    mako                                # Notification daemon
    pavucontrol                         # Graphical volume control
    qt5-wayland qt6-wayland             # For app compatibility
    waybar                              # Status bar
    xdg-desktop-portal-hyprland         # Desktop portal for Hyprland

    # --- Complete Audio Stack ---
    pipewire                            # The core audio server
    wireplumber                         # The session manager for PipeWire
    pipewire-pulse                      # PulseAudio compatibility layer
    pipewire-alsa                       # ALSA compatibility layer
    pipewire-jack                       # JACK compatibility layer (replaces jack2)

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