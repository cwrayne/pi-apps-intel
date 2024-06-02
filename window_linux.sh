#!/bin/bash

# Function to check and install dialog
install_dialog() {
    if ! command -v dialog &>/dev/null; then
        echo "dialog is not installed. Installing..."
        sudo apt-get install -y dialog
    fi
}

# Check and install dialog
install_dialog

# Define folders and their corresponding apps
declare -A folders=(
    ["All Apps"]="Chrome"
    ["Internet"]="Chrome"
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
    app_list=${folders["./apps/$menuitem"]}
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
                    # Display message while installing
                    echo "Installing $app..."
                    bash "./apps/$app/install.sh"
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
