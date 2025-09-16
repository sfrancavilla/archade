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
source ./scripts/install/astal.sh

# Install the default configurations
source ./scripts/config/base.sh

echo "#####################################################"
echo "#                                                   #"
echo "#            ARCHADE SETUP COMPLETE!                #"
echo "#      The system will reboot in 5 seconds.         #"
echo "#                                                   #"
echo "#####################################################"

# Reboot the system after 5 seconds
source ./scripts/install/reboot.sh