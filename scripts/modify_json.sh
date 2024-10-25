#!/usr/bin/env bash

# Check if the file path is provided
if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/your/file.json"
    exit 1
fi

# Define the file variable
FILE_PATH="$1"
LOG_FILE="modification_log.txt"

# Backup the original file
cp "$FILE_PATH" "${FILE_PATH}.bak"

# Initialize the log file
echo "Modification Log for $FILE_PATH" > "$LOG_FILE"
echo "-----------------------------------" >> "$LOG_FILE"

# Log changes before removing the dot after </strong>
echo "Lines before removing dot after </strong>:" >> "$LOG_FILE"
rg '</strong>\.' "$FILE_PATH" >> "$LOG_FILE"

# Use sed to remove the dot right after the </strong> tag
sed -i 's#</strong>\.#</strong>#g' "$FILE_PATH"

# Log changes after removing the dot
echo -e "\nLines after removing dot after </strong>:" >> "$LOG_FILE"
rg '</strong>' "$FILE_PATH" >> "$LOG_FILE"

# Log changes before adding a dot after </artefact>
echo -e "\nLines before adding dot after </artefact>:" >> "$LOG_FILE"
rg '</artefact>\([^\.]\|$\)' "$FILE_PATH" >> "$LOG_FILE"

# Use sed to add a dot at the end of </artefact> if not already present
sed -i 's#</artefact>\([^\.]\|\)$#</artefact>.#g' "$FILE_PATH"

# Log changes after adding the dot
echo -e "\nLines after adding dot after </artefact>:" >> "$LOG_FILE"
rg '</artefact>' "$FILE_PATH" >> "$LOG_FILE"

echo "Modifications completed. A backup of the original file is saved as ${FILE_PATH}.bak"
echo "Check the log file ${LOG_FILE} for details of the modifications."
