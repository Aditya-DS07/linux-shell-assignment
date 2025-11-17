#!/bin/bash

# Script Name: backup_directory.sh
# Description: Backs up a directory with a timestamp.

# 1. Check if the user provided 2 arguments (Source and Destination)
if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_destination>"
    echo "Example: $0 /home/user/project /home/user/backups"
    exit 1
fi

SOURCE_DIR="$1"
BACKUP_BASE="$2"

# 2. Verify source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist!"
    exit 1
fi

# 3. Create backup destination if it doesn't exist
if [ ! -d "$BACKUP_BASE" ]; then
    echo "Creating backup base directory: $BACKUP_BASE"
    mkdir -p "$BACKUP_BASE"
fi

# 4. Generate Timestamp and New Folder Name
TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
DIR_NAME=$(basename "$SOURCE_DIR")
BACKUP_PATH="$BACKUP_BASE/${DIR_NAME}_backup_$TIMESTAMP"

# 5. Perform the backup
echo "Starting backup of $SOURCE_DIR to $BACKUP_PATH..."
cp -r "$SOURCE_DIR" "$BACKUP_PATH"

# 6. Verify success
if [ $? -eq 0 ]; then
    echo "Backup completed successfully!"
    echo "Backup stored at: $BACKUP_PATH"
else
    echo "Error: Backup failed."
    exit 1
fi