#!/bin/bash
#
# Archade: Post-Installation Setup Script
#

# Stop on any error
set -eo pipefail

echo "--- Starting Archade Setup ---"

# Find the directory where the script is located
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Run the setup scripts in order
bash "${SCRIPT_DIR}/scripts/01-desktop.sh"
bash "${SCRIPT_DIR}/scripts/02-apps.sh"
bash "${SCRIPT_DIR}/scripts/03-dotfiles.sh"

echo "#####################################################"
echo "#                                                   #"
echo "#            ARCHADE SETUP COMPLETE!                #"
echo "#      Please reboot for all changes to apply.      #"
echo "#                                                   #"
echo "#####################################################"
