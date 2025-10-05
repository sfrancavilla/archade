#!/bin/bash

# A script to install applications from the AUR using yay.

# Stop on any error
set -eo pipefail

echo "--- Installing AUR Applications ---"

# --- APPLICATIONS ---
# List of packages to install from the AUR
AUR_PACKAGES=(
  cursor-bin
  google-chrome
  docker
)
yay -S --noconfirm ${AUR_PACKAGES[@]}

echo "--- AUR application install complete! ---"
