#!/bin/bash

# Script Name: auto_download.sh
# Usage: ./auto_download.sh <URL> <Target_Folder>

if [ $# -lt 1 ]; then
    echo "Usage: $0 <URL> [directory]"
    exit 1
fi

URL="$1"
DEST_DIR="${2:-$HOME/Downloads}"

# Create directory if missing
mkdir -p "$DEST_DIR"

echo "Downloading $URL to $DEST_DIR..."

# Check for tools and download
if command -v wget &> /dev/null; then
    wget -P "$DEST_DIR" "$URL"
elif command -v curl &> /dev/null; then
    cd "$DEST_DIR" && curl -O "$URL"
else
    echo "Error: Neither wget nor curl found."
    exit 1
fi

if [ $? -eq 0 ]; then
    echo "Download Success!"
else
    echo "Download Failed."
fi