#!/bin/bash

# Stop on any error
set -eo pipefail

# --- 1. ENABLE CORE SERVICES ---
echo ""
echo "--- Enabling core system services... ---"
# Enable NetworkManager to handle all network connections
sudo systemctl enable NetworkManager.service
echo "  -> NetworkManager service enabled."

# As a safety measure, explicitly disable iwd to prevent conflicts.
sudo systemctl disable iwd.service 2>/dev/null || true
echo "  -> Conflicting iwd service disabled (if it existed)."