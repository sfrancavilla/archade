#!/bin/bash

# This script installs the Astal library AND its associated applications by compiling them from source.
# It handles dependencies, uses a safe temporary build directory, and cleans up automatically.

# Stop on any error
set -eo pipefail

# --- 0. SETUP AND CLEANUP ---
# Create a temporary directory in the user's home directory to avoid size limits of /tmp.
BUILD_DIR=$(mkap -d "$HOME/astal-build.XXXXXX")

# Define a cleanup function. This will be called when the script exits for any reason.
cleanup() {
  echo "--- Cleaning up temporary build directory: $BUILD_DIR ---"
  rm -rf "$BUILD_DIR"
}

# Set a trap to run the cleanup function on exit, error, or interrupt.
trap cleanup EXIT ERR INT TERM

# --- 1. CLONE AND BUILD ---
echo "--- Cloning Astal from source... ---"

# Navigate into our safe temporary directory
pushd "$BUILD_DIR"

# Clone the official Astal repository
git clone https://github.com/aylur/astal.git
cd astal


# --- Part A: Build and Install the Core Library FIRST ---
echo ""
echo "--- Building and installing the Astal CORE LIBRARY... ---"
pushd lib/astal/io

# Set up the build directory using meson
echo "--- Configuring the library build with Meson... ---"
meson setup build

# Compile and install the library to the system.
echo "--- Compiling and installing the library... ---"
sudo meson install -C build

popd # Go back to the astal root directory


# --- Part B: Build and Install the Applications ---
echo ""
echo "--- Building and installing the Astal APPLICATIONS... ---"
pushd lib/apps

# Set up the build directory using meson
echo "--- Configuring the application build with Meson... ---"
meson setup build

# Compile and install the applications to the system.
echo "--- Compiling and installing the applications... ---"
sudo meson install -C build

popd # Go back to the astal root directory


# Go back to the original directory before cleanup
popd


echo ""
echo "--- Astal library and applications have been successfully installed! ---"
# The 'cleanup' function will now be called automatically by the trap.

