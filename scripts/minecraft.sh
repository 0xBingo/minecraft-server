#!/bin/bash

# Variables
MINECRAFT_DOMAIN="mc.example.com"
CLOUDFLARED_URL="https://github.com/cloudflare/cloudflared/releases/download/2024.12.2/cloudflared-windows-amd64.exe"
CLOUDFLARED_EXE="cloudflared-windows-amd64.exe"
DOWNLOAD_DIR="$HOME/.minecraft"
COMMAND_ARGS="access tcp --hostname $MINECRAFT_DOMAIN --url localhost:25565"

# Ensure the Downloads folder exists, create it if missing
if [ ! -d "$DOWNLOAD_DIR" ]; then
    echo "'.minecraft' folder not found. Creating it..."
    mkdir -p "$DOWNLOAD_DIR"
    if [ $? -ne 0 ]; then
        echo "Failed to create '.minecraft' folder. Exiting."
        exit 1
    fi
    echo "'.minecraft' folder created successfully."
fi

# Check if cloudflared executable exists in the Downloads folder
if [ ! -f "$DOWNLOAD_DIR/$CLOUDFLARED_EXE" ]; then
    echo "Downloading cloudflared to the Downloads folder..."
    wget -O "$DOWNLOAD_DIR/$CLOUDFLARED_EXE" "$CLOUDFLARED_URL"
    if [ $? -ne 0 ]; then
        echo "Failed to download cloudflared. Exiting."
        exit 1
    fi
    chmod +x "$DOWNLOAD_DIR/$CLOUDFLARED_EXE"
    echo "cloudflared downloaded successfully."
else
    echo "cloudflared already exists in the Downloads folder. Skipping download."
fi

# Execute cloudflared command
echo "Executing cloudflared..."
"$DOWNLOAD_DIR/$CLOUDFLARED_EXE" $COMMAND_ARGS

exit 0
