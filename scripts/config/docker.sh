#!/bin'bash

# A script to configure Docker for the current user.

# Stop on any error
set -eo pipefail

echo "--- Configuring Docker ---"

# Enable the Docker service to start on boot
sudo systemctl enable --now docker.service

# Add the current user to the 'docker' group to run docker without sudo
sudo usermod -aG docker $USER

echo "--- Docker configuration complete! ---"
echo "IMPORTANT: You must log out and log back in for Docker permissions to take effect."
