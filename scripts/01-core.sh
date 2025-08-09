#!/bin/bash

# Stop on any error
set -eo pipefail

echo "--- Installing essential packages for building ---"
# We need git and base-devel to build packages from the AUR
sudo pacman -S --noconfirm --needed git base-devel

# --- INSTALL YAY (AUR HELPER) ---
# We need an AUR helper to easily install packages from the Arch User Repository.
if ! command -v yay &> /dev/null
then
    echo "--- yay not found. Installing now... ---"
    # Temporarily navigate to /tmp to build yay
    pushd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    # Build and install the package as the current user
    makepkg -si --noconfirm
    # Return to the original directory
    popd
    echo "--- yay installation complete ---"
else
    echo "--- yay is already installed. Skipping. ---"
fi

# --- INSTALL HYPRLAND AND CORE COMPONENTS ---
echo "--- Installing Hyprland and essential components... ---"

# List of packages to install via yay
PACKAGES=(
    hyprland
    waybar
    wofi
    kitty
    mako           # Notification daemon
    thunar         # File manager
    polkit-kde-agent # Provides a graphical password prompt
    pipewire       # Audio server
    wireplumber    # Session manager for PipeWire
    xdg-desktop-portal-hyprland
    qt5-wayland qt6-wayland # For app compatibility
    ttf-nerd-fonts-symbols-common # Font with icons
    noto-fonts noto-fonts-cjk noto-fonts-emoji # Good default fonts
)

# Use yay to install all the packages
yay -S --noconfirm ${PACKAGES[@]}

echo "--- Desktop Environment installation complete! ---"
