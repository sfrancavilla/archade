#!/bin/bash

# Check if wofi is already running
if pgrep -x "wofi" > /dev/null; then
    # If wofi is running, kill it
    pkill wofi
else
    # If wofi is not running, start it
    wofi
fi
