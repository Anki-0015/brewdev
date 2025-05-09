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

# Install OpenJDK
echo -e "${BLUE}Installing OpenJDK...${NC}"
sudo apt-get install -y openjdk-17-jdk

# Verify installation
echo -e "${BLUE}Verifying installation...${NC}"
java -version

echo -e "${GREEN}✅ Java installation completed!${NC}" 