#!/bin/bash

set -oue pipefail

CURRENT_DIR="$(pwd)"
SOURCE_DIR="$(pwd)/ori" # Directory containing the original .deb files
DATE=$(date +%Y%m%d) # Current date in YYYYMMDD format

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
        } &
    else
        echo "Skipping: $deb_file"
    fi
done

# Wait for all parallel tasks to complete
wait

echo "deb-reversion works are done, all modified files are in: $CURRENT_DIR"
echo "Cleanup......."
rm -r "$SOURCE_DIR"
echo "Run ls"
ls

