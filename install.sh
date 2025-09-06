#!/bin/bash
#
# Archade: Post-Installation Setup Script
#

# Stop on any error
set -eo pipefail

echo "--- Starting Archade Setup ---"

# Run the setup scripts in order
source ./scripts/01-core.sh
source ./scripts/02-apps.sh
source ./scripts/03-dotfiles.sh

echo "#####################################################"
echo "#                                                   #"
echo "#            ARCHADE SETUP COMPLETE!                #"
echo "#      Please reboot for all changes to apply.      #"
echo "#                                                   #"
echo "#####################################################"
