#!/usr/bin/env bash

# Define paths
SCRIPT_SRC="matrix_mta"
SCRIPT_DEST="/usr/local/bin/matrix_mta"
CONFIG_SRC="matrix_mta.conf"
CONFIG_DEST="/etc/matrix_mta.conf"

# Install the script
if cp "$SCRIPT_SRC" "$SCRIPT_DEST"; then
    echo "Installed $SCRIPT_SRC to $SCRIPT_DEST"
    chmod +x "$SCRIPT_DEST"
else
    echo "Failed to install $SCRIPT_SRC"
    exit 1
fi

# Install the configuration file
if cp "$CONFIG_SRC" "$CONFIG_DEST"; then
    echo "Installed $CONFIG_SRC to $CONFIG_DEST"
else
    echo "Failed to install $CONFIG_SRC"
    exit 1
fi

echo "Installation complete."
