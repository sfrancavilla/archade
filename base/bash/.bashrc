#!/bin/bash

# fastfetch is a nice way to show the system info
if command -v fastfetch &> /dev/null; then
    fastfetch
fi

# Initialize Starship Prompt
eval "$(starship init bash)"