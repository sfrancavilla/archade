#!/bin/bash

# This script prompts the user for a system reboot with a 5-second timeout.
# If no input is given, it defaults to rebooting.

# --- PROMPT FOR REBOOT WITH TIMEOUT ---
echo "A reboot is recommended to ensure all changes take effect."
echo "The system will automatically reboot in 5 seconds."

# Use 'read -t 5' to wait for input for 5 seconds.
# The prompt (Y/n) indicates that 'Yes' is the default action.
# The return code of 'read' will be non-zero on timeout.
read -t 5 -p "Do you want to reboot now? (Y/n): " choice

# Check if the user explicitly entered 'n' or 'N'.
# If they entered anything else (including 'y', 'yes', or just pressing Enter),
# or if the command timed out (leaving $choice empty), the script will proceed to reboot.
if [[ "$choice" =~ ^[Nn]$ ]]; then
    echo "--- Reboot cancelled. Please remember to reboot your system later. ---"
else
    # This block will execute if the user confirms, hits Enter, or if the timeout is reached.
    echo "--- Rebooting system... ---"
    sudo reboot
fi

