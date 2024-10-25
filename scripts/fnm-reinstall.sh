#!/bin/bash

# Check if enough arguments are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <old-version> <new-version>"
  exit 1
fi

# Arguments from the command line
OLD_VERSION=$1
NEW_VERSION=$2

# Check if fnm is installed
if ! command -v fnm &> /dev/null; then
    echo "fnm not found! Please install it first: https://fnm.vercel.app"
    exit 1
fi

# Install the new version of Node.js
echo "Installing Node.js version $NEW_VERSION..."
fnm install $NEW_VERSION

# Reinstall global packages from the old version
if [[ -n "$OLD_VERSION" ]]; then
    echo "Reinstalling packages from Node.js version $OLD_VERSION..."
    fnm use $NEW_VERSION --install-if-missing $OLD_VERSION
fi

# Set the new version as the default
fnm default $NEW_VERSION

# Verify installation
echo "Node.js version $NEW_VERSION has been installed and set as the default."
fnm list

