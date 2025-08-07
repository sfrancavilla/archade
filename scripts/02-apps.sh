#!/bin/bash

# Stop on any error
set -eo pipefail

echo "--- Installing User Applications ---"

# --- Web Browser ---
echo "Installing Google Chrome..."
yay -S --noconfirm google-chrome

# --- Development Tools ---
echo "Installing Cursor IDE..."
yay -S --noconfirm cursor-bin

echo "Installing Docker..."
yay -S --noconfirm docker

echo "Configuring Docker to run without sudo..."
# Add the current user to the 'docker' group.
sudo usermod -aG docker $USER

# Enable the Docker systemd service, so it starts on boot.
sudo systemctl enable --now docker.service

echo "--- Application installation complete! ---"
echo "IMPORTANT: You must log out and log back in for the Docker group changes to take effect."