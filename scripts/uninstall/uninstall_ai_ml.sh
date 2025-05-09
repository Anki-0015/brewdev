#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to uninstall Python and related packages
uninstall_python_packages() {
    echo -e "${BLUE}Uninstalling Python packages...${NC}"
    
    # Uninstall AI/ML packages
    echo -e "${BLUE}Uninstalling AI/ML packages...${NC}"
    pip3 uninstall -y numpy scipy pandas matplotlib seaborn
    pip3 uninstall -y scikit-learn tensorflow keras
    pip3 uninstall -y torch torchvision torchaudio
    pip3 uninstall -y nltk spacy transformers
    pip3 uninstall -y plotly bokeh dash
    pip3 uninstall -y jupyter ipywidgets tqdm requests beautifulsoup4
    
    # Uninstall Jupyter
    echo -e "${BLUE}Uninstalling Jupyter...${NC}"
    pip3 uninstall -y notebook jupyterlab
    
    # Uninstall Python
    echo -e "${BLUE}Uninstalling Python...${NC}"
    sudo apt-get purge -y python3 python3-pip python3-venv
    sudo apt-get autoremove -y
}

# Function to uninstall Git
uninstall_git() {
    echo -e "${BLUE}Uninstalling Git...${NC}"
    sudo apt-get purge -y git
    sudo apt-get autoremove -y
}

# Show help
show_help() {
    echo -e "${BLUE}AI/ML Environment Uninstaller${NC}"
    echo
    echo -e "${YELLOW}Usage:${NC} ./uninstall_ai_ml.sh"
    echo
    echo -e "${YELLOW}Description:${NC}"
    echo -e "  Uninstalls the complete AI/ML environment including:"
    echo -e "  - Python and all AI/ML packages"
    echo -e "  - Jupyter Notebook and Jupyter Lab"
    echo -e "  - Git"
    echo
    echo -e "${YELLOW}Options:${NC}"
    echo -e "  ${GREEN}--help${NC}, ${GREEN}-h${NC}          Show this help message"
}

# Check for help flag
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_help
    exit 0
fi

# Confirm uninstallation
echo -e "${YELLOW}Are you sure you want to uninstall the AI/ML environment? (y/N)${NC}"
read -r response
if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo -e "${BLUE}Uninstallation cancelled.${NC}"
    exit 0
fi

# Start uninstallation
echo -e "${BLUE}Starting AI/ML environment uninstallation...${NC}"

# Uninstall Python and packages
uninstall_python_packages

# Uninstall Git
uninstall_git

# Clean up
echo -e "${BLUE}Cleaning up...${NC}"
sudo apt-get autoremove -y
sudo apt-get clean

echo -e "${GREEN}✅ AI/ML environment uninstallation completed!${NC}" 