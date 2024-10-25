#!/bin/bash

# Check if fd command is available
if ! command -v fd &> /dev/null; then
  echo "fd command not found. Please install fd first."
  exit 1
fi

# Function to process and clean a .vtt file
process_vtt_file() {
  local input_file="$1"
  local temp_file

  temp_file=$(mktemp)

  # Create a temporary file to store the modified content
  while IFS= read -r line; do
    # Check if the line starts with '- ' and modify it
    if [[ "$line" =~ ^- ]]; then
      line="${line#- }"
    fi
    # Write the processed line to the temporary file
    echo "$line" >> "$temp_file"
  done < "$input_file"

  # Replace the original file with the modified content
  mv "$temp_file" "$input_file"

  echo "Processed file: $input_file"
}

export -f process_vtt_file

# Find all .vtt files and process them
fd -e vtt -x sh -c '
  for file; do
    dir="$(dirname "$file")"
    new_name="$dir/Français.vtt"
    
    # Check if the destination file already exists
    if [ -e "$new_name" ]; then
      echo "File already exists: $new_name. Skipping."
      continue
    fi

    # Rename the file
    mv "$file" "$new_name"
    
    # Process the renamed file
    process_vtt_file "$new_name"
  done
' sh {} +

echo "All files have been processed and updated."
