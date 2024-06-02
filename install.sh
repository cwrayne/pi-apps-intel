#!/bin/bash

# Start text
echo Pi Apps Intel v0.1
cat << "EOF"
 ██████  ██      █████  ██████  ██████  ███████ 
 ██   ██ ██     ██   ██ ██   ██ ██   ██ ██      
 ██████  ██     ███████ ██████  ██████  ███████ 
 ██      ██     ██   ██ ██      ██           ██ 
 ██      ██     ██   ██ ██      ██      ███████ 
                                      
 ██ ███    ██ ████████ ███████ ██      
 ██ ████   ██    ██    ██      ██      
 ██ ██ ██  ██    ██    █████   ██      
 ██ ██  ██ ██    ██    ██      ██      
 ██ ██   ████    ██    ███████ ███████ 
EOF

# Check if the architecture is ARM
if dpkg --print-architecture | grep -q arm; then
    echo "ARM computer! Please install normal pi-apps."
    read -p "Would you like to install pi-apps? (y/n) " answer
    if [ "$answer" = "y" ]; then
        wget -qO- https://raw.githubusercontent.com/Botspot/pi-apps/master/install | bash
        exit
    elif [ "$answer" = "n" ]; then
        echo "exiting..."
        exit
    fi
else
    echo "intel computer! continuing..."
fi
