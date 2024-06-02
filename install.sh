#!/bin/bash

# Function to check and install wget
install_wget() {
    if ! command -v wget &>/dev/null; then
        echo "wget is not installed. Installing..."
        sudo apt-get install -y wget
    fi
}

# Check and install wget
install_wget

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
        echo "Exiting..."
        exit
    fi
else
    echo "Intel computer! Continuing..."
fi

bash

# Add shortcut to desktop