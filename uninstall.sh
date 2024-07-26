#!/usr/bin/env bash

# Define paths
SCRIPT_DEST="/usr/local/bin/matrix_mta"
CONFIG_DEST="/etc/matrix_mta.conf"
ROOM_ID_FILE="/var/matrix_mta/room-id"

# Remove the script
if rm "$SCRIPT_DEST"; then
    echo "Removed $SCRIPT_DEST"
else
    echo "Failed to remove $SCRIPT_DEST"
    exit 1
fi

# Remove the configuration file
if rm "$CONFIG_DEST"; then
    echo "Removed $CONFIG_DEST"
else
    echo "Failed to remove $CONFIG_DEST"
    exit 1
fi

# Remove the room-id file
if rm "$ROOM_ID_FILE"; then
    echo "Removed $ROOM_ID_FILE"
else
    # Check if it exists in the current directory
    if [[ -f "./room-id" ]]; then
        if rm "./room-id"; then
            echo "Removed ./room-id"
        else
            echo "Failed to remove ./room-id"
            exit 1
        fi
    else
        echo "$ROOM_ID_FILE not found"
    fi
fi

echo "Uninstallation complete."
