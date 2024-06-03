#!/bin/bash

# Function to check and install dialog
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

# Function to install apps
install_apps() {
    # Define folders and their corresponding apps
    declare -A folders=(
        ["All Apps"]="Chrome"
        ["Internet"]="Chrome"
        ["Emulators"]="QEMU"
    )

    # Define install scripts for each app
    declare -A install_scripts=(
        ["Chrome"]="./apps/linux/Chrome/install.sh"
        ["QEMU"]="./apps/linux/QEMU/install.sh"
    )

    # Start window
    dialog --clear --title "App Installer" --menu "Choose an app category:" 15 50 4 \
        "All Apps" "Install all apps" \
        "Internet" "Install internet-related apps" \
        "Emulators" "Install emulators" \
        2>/tmp/menuitem.$$

    # Get selection status
    category=$(cat /tmp/menuitem.$$)
    rm /tmp/menuitem.$$

    # Check if the user selected a category
    if [ "$category" != "" ]; then
        # Get the list of apps for the selected category
        app_list=${folders[$category]}
        # Convert the app list to an array
        IFS=', ' read -r -a apps <<< "$app_list"

        # Start window to choose an app
        dialog --clear --title "App Installer" --menu "Choose an app:" 15 50 4 \
            ${apps[@]/#/ } \
            2>/tmp/menuitem.$$

        # Get selection status
        app=$(cat /tmp/menuitem.$$)
        rm /tmp/menuitem.$$

        # Check if the user selected an app
        if [ "$app" != "" ]; then
            # Check if the app has an associated install script
            if [ "${install_scripts[$app]+exists}" ]; then
                # Run the install script for the app
                bash "${install_scripts[$app]}"
            else
                echo "No install script found for $app"
            fi
        else
            echo "No app selected"
        fi
    else
        echo "No category selected"
    fi
}

# Main function
main() {
    install_dialog
    install_apps
}

# Execute main function
main
