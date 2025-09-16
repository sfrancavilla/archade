#!/bin/bash

# This script installs the Astal library by compiling it from source.
# It handles dependencies, uses a safe temporary build directory, and cleans up automatically.

# Stop on any error
set -eo pipefail

# --- 0. SETUP AND CLEANUP ---
# Create a temporary directory in the user's home directory to avoid size limits of /tmp.
BUILD_DIR=$(mktemp -d "$HOME/astal-build.XXXXXX")

# Define a cleanup function. This will be called when the script exits for any reason.
cleanup() {
  echo "--- Cleaning up temporary build directory: $BUILD_DIR ---"
  rm -rf "$BUILD_DIR"
}

# Set a trap to run the cleanup function on exit, error, or interrupt.
trap cleanup EXIT ERR INT TERM

# --- 1. CLONE AND BUILD ASTAL ---
# Astral required library have been installed in the hyprland-apps.sh script
echo "--- Cloning and building Astal from source... ---"

# Navigate into our safe temporary directory
pushd "$BUILD_DIR"

# Clone the official Astal repository
git clone https://github.com/aylur/astal.git

# Navigate to the specific subdirectory required for the build
cd astal/lib/astal/io

# Set up the build directory using meson
echo "--- Configuring the build with Meson... ---"
meson setup build

# Compile and install the library to the system.
# 'meson install' typically requires root privileges.
echo "--- Compiling and installing Astal... ---"
sudo meson install -C build

# Go back to the original directory before cleanup
popd


echo ""
echo "--- Astal has been successfully installed! ---"
# The 'cleanup' function will now be called automatically by the trap.
