#!/bin/bash

# A script to install the 'yay' AUR helper.

# Stop on any error
set -eo pipefail

echo "--- Installing 'yay' AUR Helper ---"

# 1. Clone, build, and install yay
pushd /tmp
if [ -d "yay" ]; then
  rm -rf yay
fi
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
popd

echo "--- 'yay' has been successfully installed! ---"
