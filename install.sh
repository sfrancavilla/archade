#!/bin/bash
#
# Archade: Post-Installation Setup Script
#

# Stop on any error
set -eo pipefail

echo "--- Starting Archade Setup ---"

# Run the setup scripts in order
source ./scripts/install/pacman.sh
source ./scripts/install/hyprland-apps.sh
source ./scripts/install/hyprland-fonts.sh

echo "#####################################################"
echo "#                                                   #"
echo "#            ARCHADE SETUP COMPLETE!                #"
echo "#      Please reboot for all changes to apply.      #"
echo "#                                                   #"
echo "#####################################################"
