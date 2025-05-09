#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to uninstall language-specific tools
uninstall_language() {
    local lang=$1
    case $lang in
        python)
            echo -e "${BLUE}Uninstalling Python...${NC}"
            sudo apt-get purge -y python3 python3-pip python3-venv
            sudo apt-get autoremove -y
            ;;
        node)
            echo -e "${BLUE}Uninstalling Node.js...${NC}"
            sudo apt-get purge -y nodejs npm
            sudo apt-get autoremove -y
            ;;
        java)
            echo -e "${BLUE}Uninstalling Java...${NC}"
            sudo apt-get purge -y openjdk-17-jdk
            sudo apt-get autoremove -y
            ;;
        go)
            echo -e "${BLUE}Uninstalling Go...${NC}"
            sudo apt-get purge -y golang-go golang
            sudo apt-get autoremove -y
            # Remove manually installed Go
            if [ -d "/usr/local/go" ]; then
                sudo rm -rf /usr/local/go
                sudo rm -f /usr/local/bin/go
                sudo rm -f /usr/local/bin/gofmt
            fi
            ;;
        *)
            echo -e "${RED}Unknown language: $lang${NC}"
            exit 1
            ;;
    esac
}

# Function to uninstall common tools
uninstall_common_tools() {
    echo -e "${BLUE}Uninstalling common tools...${NC}"
    
    # Uninstall Git
    echo -e "${BLUE}Uninstalling Git...${NC}"
    sudo apt-get purge -y git
    sudo apt-get autoremove -y
    
    # Uninstall Docker
    echo -e "${BLUE}Uninstalling Docker...${NC}"
    sudo apt-get purge -y docker.io docker-ce docker-ce-cli containerd.io
    sudo apt-get autoremove -y
    sudo rm -rf /var/lib/docker
    
    # Uninstall Docker Hub
    echo -e "${BLUE}Uninstalling Docker Hub...${NC}"
    sudo snap remove docker-hub
    
    # Uninstall Postman
    echo -e "${BLUE}Uninstalling Postman...${NC}"
    sudo snap remove postman
    
    # Uninstall PostgreSQL
    echo -e "${BLUE}Uninstalling PostgreSQL...${NC}"
    sudo apt-get purge -y postgresql postgresql-contrib
    sudo apt-get autoremove -y
    sudo rm -rf /var/lib/postgresql
}

# Show help
show_help() {
    echo -e "${BLUE}Fullstack Environment Uninstaller${NC}"
    echo
    echo -e "${YELLOW}Usage:${NC} ./uninstall_fullstack.sh [language]"
    echo
    echo -e "${YELLOW}Languages:${NC}"
    echo -e "  ${GREEN}python${NC}                   Python"
    echo -e "  ${GREEN}node${NC}                     Node.js"
    echo -e "  ${GREEN}java${NC}                     Java"
    echo -e "  ${GREEN}go${NC}                       Go"
    echo
    echo -e "${YELLOW}Options:${NC}"
    echo -e "  ${GREEN}--help${NC}, ${GREEN}-h${NC}          Show this help message"
    echo
    echo -e "${YELLOW}Examples:${NC}"
    echo -e "  ./uninstall_fullstack.sh python"
    echo -e "  ./uninstall_fullstack.sh node"
}

# Check for help flag
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_help
    exit 0
fi

# Check if language is provided
if [[ -z "$1" ]]; then
    echo -e "${RED}Please specify a language to uninstall${NC}"
    show_help
    exit 1
fi

# Confirm uninstallation
echo -e "${YELLOW}Are you sure you want to uninstall the fullstack environment with $1? (y/N)${NC}"
read -r response
if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo -e "${BLUE}Uninstallation cancelled.${NC}"
    exit 0
fi

# Start uninstallation
echo -e "${BLUE}Starting fullstack environment uninstallation...${NC}"

# Uninstall language-specific tools
uninstall_language "$1"

# Uninstall common tools
uninstall_common_tools

# Clean up
echo -e "${BLUE}Cleaning up...${NC}"
sudo apt-get autoremove -y
sudo apt-get clean

echo -e "${GREEN}✅ Fullstack environment uninstallation completed!${NC}"