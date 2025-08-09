#!/bin/zsh

# zsh needs to be the default shell by running chsh -s $(which zsh)

# fastfetch is a nice way to show the system info
if command -v fastfetch &> /dev/null; then
    fastfetch
fi