#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if snap is installed
if ! command -v snap &> /dev/null; then
    echo -e "${YELLOW}Installing snap...${NC}"
    sudo apt-get update
    sudo apt-get install -y snapd
fi

# Install Postman using snap
echo -e "${BLUE}Installing Postman...${NC}"
sudo snap install postman

# Verify installation
if command -v postman &> /dev/null; then
    echo -e "${GREEN}Postman has been installed successfully!${NC}"
else
    echo -e "${RED}Postman installation failed. Please try installing manually from https://www.postman.com/downloads/${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Postman installation completed!${NC}" 