#!/bin/bash

echo "That's it! Rebooting system in 5 seconds..."

for i in {5..1}; do
    echo -n "Rebooting in $i... "
    read -t 1 -n 1 input 2>/dev/null
    if [ $? -eq 0 ]; then
        echo
        echo "Reboot cancelled by user."
        exit 0
    fi
    echo -ne "\r\033[K"
done

echo "Rebooting now!"
reboot

