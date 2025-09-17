#!/bin/bash

# Install Hyprland core dependencies, handling potential conflicts.

# Stop on any error
set -eo pipefail

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

    # --- Hardware Support ---
    alsa-firmware                       # Essential firmware for many sound cards
    sof-firmware                        # Firmware for modern Intel/AMD sound hardware (CRITICAL)

    # --- Complete Audio Stack ---
    alsa-utils                          # For debugging tools like aplay, amixer

    pipewire                            # The core audio server
    wireplumber                         # The session manager for PipeWire
    pipewire-pulse                      # PulseAudio compatibility layer
    pipewire-alsa                       # ALSA compatibility layer
    pipewire-jack                       # JACK compatibility layer (replaces jack2)

    # --- Networking ---
    networkmanager                      # The primary network management daemon


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

    # --- Astal ---
    meson
    vala
    valadoc
    gobject-introspection
    json-glib
    gtk3
    gtk-layer-shell
    gtk4
    gtk4-layer-shell
)

# Install all the packages
sudo pacman -S --noconfirm --needed ${PACKAGES[@]}

echo "--- Desktop Environment installation complete! ---"