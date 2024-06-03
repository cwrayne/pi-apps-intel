#!/bin/bash

install_dialog() {
    if ! command -v dialog &>/dev/null; then
        echo "dialog is not installed. Installing..."
        if [ "$(uname)" == "Darwin" ]; then
            brew install dialog
        elif [ "$(uname)" == "Linux" ]; then
            sudo apt-get install -y dialog
        else
            echo "Unsupported operating system. Exiting..."
            exit 1
        fi
    fi
}

install_dialog

# Function to install apps
install_apps() {

    # Define install scripts for each app
    declare -A install_scripts=(
        ["Chrome"]="./apps/linux/Chrome/install.sh"
        ["QEMU"]="./apps/linux/QEMU/install.sh"
    )