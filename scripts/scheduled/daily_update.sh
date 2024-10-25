#!/bin/bash

# Function to get the current date and time
get_datetime() {
    date '+%Y-%m-%d %H:%M:%S'
}

# Run the export packages script
~/export_packages.sh

# Git config command alias (cross-platform)
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Stage changes in the ~/temp directory
config add ~/temp/*

# Stage any other changes in the repository
config add .

# Commit changes with a timestamp
datetime=$(get_datetime)
config commit -m "dotfiles updated $datetime"

# Push changes to the remote repository
config push
