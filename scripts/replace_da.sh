#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

# Input file
file="$1"

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "File not found!"
    exit 1
fi

# Count occurrences of da='something' before replacement
before=$(perl -ne 'print "$1\n" while /da=\'([^\']*)\'/g' "$file" | wc -l)

# Perform the replacement using Perl
perl -i -pe 's/da=\'[^\']*\'/da=\'\'/g' "$file"

# Count occurrences of da='something' after replacement
after=$(perl -ne 'print "$1\n" while /da=\'([^\']*)\'/g' "$file" | wc -l)

# Calculate number of replacements
replaced=$((before - after))

# Print the result
echo "Number of replacements: $replaced"
