#!/bin/bash

# Function to fetch the latest LTS version using fnm
get_lts_version() {
    fnm list-remote --lts | tail -1
}

# Check if a Node.js version argument is provided
if [ $# -ne 1 ]; then
    echo "No Node.js version provided."
    read -p "Do you want to use the latest LTS version? (y/n): " use_lts

    if [[ "$use_lts" == "y" || "$use_lts" == "Y" ]]; then
        NODE_VERSION=$(get_lts_version)
        echo "Using latest LTS version: $NODE_VERSION"
    else
        read -p "Please enter the Node.js version you want to install: " NODE_VERSION
    fi
else
    # Node.js version from the command line argument
    NODE_VERSION=$1
fi

# Define the global npm packages you want to install
GLOBAL_PACKAGES=(
    "@astrojs/language-server@2.14.2"
    "@olrtg/emmet-language-server@2.6.0"
    "@tailwindcss/language-server@0.0.16"
    "@vue/language-server@2.1.6"
    "@vue/typescript-plugin@2.1.6"
    "bash-language-server@5.4.0"
    "corepack@0.20.0"
    "file-type-cli@6.0.0"
    "json@11.0.0"
    "npm@9.9.3"
    "prettier@3.3.3"
    "sql-language-server@1.7.0"
    "typescript-language-server@3.3.2"
    "typescript@5.6.2"
    "vscode-langservers-extracted@4.10.0"
    "yaml-language-server@1.15.0"
)

# Check if fnm is installed
if ! command -v fnm &> /dev/null
then
    echo "fnm not found! Please install it first: https://fnm.vercel.app"
    exit 1
fi

# Install the Node.js version
echo "Installing Node.js version $NODE_VERSION..."
fnm install $NODE_VERSION

# Use the newly installed Node.js version
fnm use $NODE_VERSION

# Set the new version as the default
fnm default $NODE_VERSION

# Install global npm packages
echo "Installing global npm packages..."
for PACKAGE in "${GLOBAL_PACKAGES[@]}"; do
    echo "Installing $PACKAGE..."
    npm install -g $PACKAGE
done

# Verify installation
echo "Node.js version $NODE_VERSION has been installed and set as the default."
echo "The following global npm packages have been installed:"
npm list -g --depth=0

echo "Installation complete!"
