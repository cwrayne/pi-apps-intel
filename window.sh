#!/bin/bash

# Define folders and their corresponding apps
declare -A folders=(
    ["All Apps"]="Chrome, Firefox, Chromium, QEMU"
    ["Internet"]="Chrome, Firefox, Chromium"
    ["Emulators"]="QEMU"
)

# Define install scripts for each app
declare -A install_scripts=(
    ["chrome"]="./apps/Chrome/install.sh"
    ["chromium"]="./apps/Chromium/install.sh"
    ["firefox"]="./apps/Firefox/install.sh"
    ["qemu"]="./apps/QEMU/install.sh"
)

# Start window
dialog --clear --title "App Installer" --menu "Choose an app category:" 15 50 4 \
    "All Apps" "Install all apps" \
    "Internet" "Install internet-related apps" \
    "Emulators" "Install emulators" \
    2>/tmp/menuitem.$$

# Get selection status
menuitem=$(cat /tmp/menuitem.$$)
rm /tmp/menuitem.$$

# Check if the user selected a category
if [ "$menuitem" != "" ]; then
    # Get the list of apps for the selected category
    app_list=${folders[$menuitem]}
    # Convert the app list to an array
    IFS=', ' read -r -a apps <<< "$app_list"
    # Loop through each app and display a checkbox for installation
    for app in "${apps[@]}"; do
        # Check if the app has an associated install script
        if [ "${install_scripts[$app]+exists}" ]; then
            dialog --title "Install $app?" --yesno "Do you want to install $app?" 10 50
            response=$?
            case $response in
                0) # User selected "Yes"
                    # Run the install script for the app
                    bash "${install_scripts[$app]}"
                    ;;
                1) # User selected "No"
                    ;;
                255) # User pressed ESC key
                    ;;
            esac
        else
            echo "No install script found for $app"
        fi
    done
else
    echo "No category selected"
fi
