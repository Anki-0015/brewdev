#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to uninstall Python
uninstall_python() {
    echo -e "${BLUE}Uninstalling Python...${NC}"
    sudo apt-get purge -y python3 python3-pip python3-venv
    sudo apt-get autoremove -y
}

# Function to uninstall Node.js
uninstall_node() {
    echo -e "${BLUE}Uninstalling Node.js...${NC}"
    sudo apt-get purge -y nodejs npm
    sudo apt-get autoremove -y
}

# Function to uninstall Java
uninstall_java() {
    echo -e "${BLUE}Uninstalling Java...${NC}"
    sudo apt-get purge -y openjdk-17-jdk
    sudo apt-get autoremove -y
}

# Function to uninstall Go
uninstall_go() {
    echo -e "${BLUE}Uninstalling Go...${NC}"
    sudo apt-get purge -y golang-go golang
    sudo apt-get autoremove -y
    if [ -d "/usr/local/go" ]; then
        sudo rm -rf /usr/local/go
        sudo rm -f /usr/local/bin/go
        sudo rm -f /usr/local/bin/gofmt
    fi
}

# Function to uninstall Git
uninstall_git() {
    echo -e "${BLUE}Uninstalling Git...${NC}"
    sudo apt-get purge -y git
    sudo apt-get autoremove -y
}

# Function to uninstall Docker
uninstall_docker() {
    echo -e "${BLUE}Uninstalling Docker...${NC}"
    sudo apt-get purge -y docker.io docker-ce docker-ce-cli containerd.io
    sudo apt-get autoremove -y
    sudo rm -rf /var/lib/docker
}

# Function to uninstall Docker Hub
uninstall_docker_hub() {
    echo -e "${BLUE}Uninstalling Docker Hub...${NC}"
    sudo snap remove docker-hub
}

# Function to uninstall Postman
uninstall_postman() {
    echo -e "${BLUE}Uninstalling Postman...${NC}"
    sudo snap remove postman
}

# Function to uninstall Jupyter
uninstall_jupyter() {
    echo -e "${BLUE}Uninstalling Jupyter...${NC}"
    pip3 uninstall -y notebook jupyterlab
}

# Function to uninstall PostgreSQL
uninstall_postgres() {
    echo -e "${BLUE}Uninstalling PostgreSQL...${NC}"
    sudo apt-get purge -y postgresql postgresql-contrib
    sudo apt-get autoremove -y
    sudo rm -rf /var/lib/postgresql
}

# Show help
show_help() {
    echo -e "${BLUE}Custom Environment Uninstaller${NC}"
    echo
    echo -e "${YELLOW}Usage:${NC} ./uninstall_custom.sh [options]"
    echo
    echo -e "${YELLOW}Options:${NC}"
    echo -e "  ${GREEN}--python${NC}              Uninstall Python"
    echo -e "  ${GREEN}--node${NC}                Uninstall Node.js"
    echo -e "  ${GREEN}--java${NC}                Uninstall Java"
    echo -e "  ${GREEN}--go${NC}                  Uninstall Go"
    echo -e "  ${GREEN}--git${NC}                 Uninstall Git"
    echo -e "  ${GREEN}--docker${NC}              Uninstall Docker"
    echo -e "  ${GREEN}--docker-hub${NC}          Uninstall Docker Hub"
    echo -e "  ${GREEN}--postman${NC}             Uninstall Postman"
    echo -e "  ${GREEN}--jupyter${NC}             Uninstall Jupyter"
    echo -e "  ${GREEN}--postgres${NC}            Uninstall PostgreSQL"
    echo -e "  ${GREEN}--help${NC}, ${GREEN}-h${NC}          Show this help message"
    echo
    echo -e "${YELLOW}Examples:${NC}"
    echo -e "  ./uninstall_custom.sh --python --node"
    echo -e "  ./uninstall_custom.sh --docker --postgres"
}

# Check for help flag
if [[ "$1" == "--help" || "$1" == "-h" || -z "$1" ]]; then
    show_help
    exit 0
fi

# Confirm uninstallation
echo -e "${YELLOW}Are you sure you want to uninstall the selected components? (y/N)${NC}"
read -r response
if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo -e "${BLUE}Uninstallation cancelled.${NC}"
    exit 0
fi

# Start uninstallation
echo -e "${BLUE}Starting custom uninstallation...${NC}"

# Process each argument
for arg in "$@"; do
    case $arg in
        --python)
            uninstall_python
            ;;
        --node)
            uninstall_node
            ;;
        --java)
            uninstall_java
            ;;
        --go)
            uninstall_go
            ;;
        --git)
            uninstall_git
            ;;
        --docker)
            uninstall_docker
            ;;
        --docker-hub)
            uninstall_docker_hub
            ;;
        --postman)
            uninstall_postman
            ;;
        --jupyter)
            uninstall_jupyter
            ;;
        --postgres)
            uninstall_postgres
            ;;
        *)
            echo -e "${RED}Unknown option: $arg${NC}"
            show_help
            exit 1
            ;;
    esac
done

# Clean up
echo -e "${BLUE}Cleaning up...${NC}"
sudo apt-get autoremove -y
sudo apt-get clean

echo -e "${GREEN}✅ Custom uninstallation completed!${NC}" 