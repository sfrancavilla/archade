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
  mako                        # Notification daemon
  pavucontrol                 # Graphical volume control
  qt5-wayland qt6-wayland     # For app compatibility
  waybar                      # Status bar
  xdg-desktop-portal-hyprland # Desktop portal for Hyprland
  xdg-desktop-portal-gtk

  # --- Hardware Support ---
  alsa-firmware # Essential firmware for many sound cards
  sof-firmware  # Firmware for modern Intel/AMD sound hardware (CRITICAL)

  # --- Complete Audio Stack ---
  alsa-utils # For debugging tools like aplay, amixer

  pipewire       # The core audio server
  wireplumber    # The session manager for PipeWire
  pipewire-pulse # PulseAudio compatibility layer
  pipewire-alsa  # ALSA compatibility layer
  pipewire-jack  # JACK compatibility layer (replaces jack2)

  # --- Utilities & Applications ---
  blueberry     # Bluetooth manager
  brightnessctl # Brightness control
  cliphist      # Clipboard history
  fastfetch     # System info
  hyprpolkitagent # Polkit agent
  hyprpaper     # Wallpaper manager
  hyprpicker    # Color picker
  hyprlock      # Lock screen
  hypridle      # Manage idle screen
  kitty         # Terminal
  nautilus      # File manager
  starship      # Prompt
  wofi          # Application launcher
  impala        # Network manager
  grim          # Screenshot tool
  slurp          # Screenshot tool
  uwsm libnewt  # Hyprland login manager
)

# Install all the packages
sudo pacman -S --noconfirm --needed ${PACKAGES[@]}

echo "--- Desktop Environment installation complete! ---"
