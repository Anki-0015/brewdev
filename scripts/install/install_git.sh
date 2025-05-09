#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Update package list
echo -e "${BLUE}Updating package list...${NC}"
sudo apt-get update

# Check if Git is already installed
if command -v git &> /dev/null; then
    echo -e "${YELLOW}Git is already installed. Updating...${NC}"
    sudo apt-get upgrade -y git
else
    echo -e "${BLUE}Installing Git...${NC}"
    sudo apt-get install -y git
fi

# Configure Git with some common settings
echo -e "${BLUE}Configuring Git...${NC}"
git config --global core.editor "code --wait"
git config --global init.defaultBranch main
git config --global pull.rebase false

# Verify installation
echo -e "${BLUE}Verifying installation...${NC}"
git --version

echo -e "${GREEN}✅ Git installation completed!${NC}" 