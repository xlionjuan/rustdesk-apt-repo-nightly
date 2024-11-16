#!/bin/bash

set -oue pipefail

current_dir=$(pwd) # Get the current working directory
SOURCE_DIR="$current_dir/ori" # Directory containing the original .deb files
TARGET_DIR="$current_dir" # Target directory for modified .deb files
DATE=$(date +%Y%m%d) # Current date in YYYYMMDD format

# Ensure the target directory exists
mkdir -p "$TARGET_DIR"

# Iterate over all .deb files in the source directory
for deb_file in "$SOURCE_DIR"/*.deb; do
    if [ -f "$deb_file" ]; then
        {
            echo "Processing: $deb_file"

            # Get the original version number from the .deb file
            original_version=$(dpkg-deb --info "$deb_file" | grep Version | awk '{print $2}')

            # Modify the version number and apply changes directly to the original .deb file
            deb-reversion --new-version="${original_version}+${DATE}" "$deb_file"

            # Remove the original file after processing
            rm -f "$deb_file"

            echo "Processed and moved: $TARGET_DIR/$(basename "$deb_file")"
        } &
    else
        echo "Skipping: $deb_file"
    fi
done

# Wait for all parallel tasks to complete
wait

echo "Done, all modified files moved to: $TARGET_DIR"
echo "Cleanup......."
rm -r "$SOURCE_DIR"
