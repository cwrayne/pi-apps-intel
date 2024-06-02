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


# Function to check and install wget
install_wget() {
    if ! command -v wget &>/dev/null; then
        echo "wget is not installed. Installing..."
        sudo apt-get install -y wget
    fi
}

# Check and install wget
install_wget



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
    echo "Detected Intel computer! Continuing..."
fi

# Check if the OS is macOS
if [ "$(uname)" == "Darwin" ]; then
    echo "macOS detected. Downloading and running window_macos.sh..."
    wget -qO- https://raw.githubusercontent.com/cwrayne/pi-apps-intel/main/window_macos.sh?token=GHSAT0AAAAAACTDAPWVLYZFDNGPQ2JMVAZ2ZS4P4AQ
    bash ./window_macos.sh
fi

# Check if the OS is Linux
if [ "$(uname)" == "Linux" ]; then
    echo "Linux detected. Downloading and running window_linux.sh..."
    wget -qO- https://raw.githubusercontent.com/cwrayne/pi-apps-intel/main/window_linux.sh?token=GHSAT0AAAAAACTDAPWVLYZFDNGPQ2JMVAZ2ZS4P4AQ
    bash ./window_linux.sh
fi

# Check if neither macOS nor Linux
if [ "$(uname)" != "Darwin" ] && [ "$(uname)" != "Linux" ]; then
    echo "Neither macOS nor Linux detected. Exiting..."
    exit
fi



# Add to PATH
export PATH="./:PATH"
source ~/.bashrc
# Add