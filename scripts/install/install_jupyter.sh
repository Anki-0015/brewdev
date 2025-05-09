#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Python 3 is not installed. Please install Python first.${NC}"
    exit 1
fi

# Install pip if not already installed
if ! command -v pip3 &> /dev/null; then
    echo -e "${YELLOW}Installing pip...${NC}"
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py
    rm get-pip.py
fi

# Install Jupyter Notebook
echo -e "${BLUE}Installing Jupyter Notebook...${NC}"
pip3 install --upgrade pip
pip3 install notebook

# Install Jupyter Lab (optional but recommended)
echo -e "${BLUE}Installing Jupyter Lab...${NC}"
pip3 install jupyterlab

# Create a default configuration
echo -e "${BLUE}Creating default configuration...${NC}"
jupyter notebook --generate-config

# Set up a default password (optional)
# echo -e "${YELLOW}Please set up a password for Jupyter Notebook:${NC}"
# jupyter notebook password

# Verify installation
echo -e "${BLUE}Verifying installation...${NC}"
jupyter --version

echo -e "${GREEN}✅ Jupyter installation completed!${NC}"
echo -e "${BLUE}To start Jupyter Notebook, run:${NC} jupyter notebook"
echo -e "${BLUE}To start Jupyter Lab, run:${NC} jupyter lab" 