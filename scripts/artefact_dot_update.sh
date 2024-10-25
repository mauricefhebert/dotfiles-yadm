#!/usr/bin/env bash

# Define the file variable
FILE_PATH="$1"

# Backup the original file
cp "$FILE_PATH" "${FILE_PATH}.bak"

# Use ripgrep to find and remove the dot immediately after </strong> tag
rg -l '</strong>\.' "$FILE_PATH" | xargs sed -i 's#</strong>\.#</strong>#g'

# Use ripgrep to find the </artefact> tag and add a dot if not already present
rg -l '</artefact>' "$FILE_PATH" | xargs sed -i 's#</artefact>#</artefact>.#g'

echo "Modifications completed. A backup of the original file is saved as ${FILE_PATH}.bak"
