#!/bin/bash
COMMAND=$1
SUBCOMMAND=$2
VERSION="0.0.1"

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

show_help() {
    echo -e "${BLUE}🍺 brewdev - Development Environment Setup Tool${NC}"
    echo
    echo -e "${YELLOW}Usage:${NC} brewdev [command] [subcommand]"
    echo
    echo -e "${YELLOW}Commands:${NC}"
    echo -e "  ${GREEN}setup${NC} [type] [language]    Install development environment"
    echo -e "  ${GREEN}uninstall${NC} [type] [lang]   Uninstall development environment"
    echo -e "  ${GREEN}gui${NC}                      Run the GUI menu"
    echo
    echo -e "${YELLOW}Setup/Uninstall Types:${NC}"
    echo -e "  ${GREEN}fullstack${NC}                Fullstack environment"
    echo -e "  ${GREEN}backend${NC}                  Backend environment"
    echo -e "  ${GREEN}ai-ml${NC}                    AI & ML environment"
    echo -e "  ${GREEN}custom${NC}                   Custom installation"
    echo
    echo -e "${YELLOW}Languages (for fullstack/backend):${NC}"
    echo -e "  ${GREEN}python${NC}                   Python"
    echo -e "  ${GREEN}node${NC}                     Node.js"
    echo -e "  ${GREEN}java${NC}                     Java"
    echo -e "  ${GREEN}go${NC}                       Go"
    echo
    echo -e "${YELLOW}Options:${NC}"
    echo -e "  ${GREEN}--help${NC}, ${GREEN}-h${NC}          Show this help message"
    echo -e "  ${GREEN}--version${NC}, ${GREEN}-v${NC}       Show brewdev version"
    echo
    echo -e "${YELLOW}Examples:${NC}"
    echo -e "  brewdev setup fullstack python"
    echo -e "  brewdev uninstall backend node"
    echo -e "  brewdev setup ai-ml"
    echo -e "  brewdev uninstall ai-ml"
    echo -e "  brewdev setup custom"
    echo -e "  brewdev gui"
}

case "$COMMAND" in
    --help|-h)
        show_help
        exit 0
        ;;
    --version|-v)
        echo -e "${GREEN}🍺 brewdev version $VERSION${NC}"
        exit 0
        ;;
esac

# Function to install language-specific tools
install_language() {
    local lang=$1
    case $lang in
        python)
            bash scripts/install/install_python.sh
            ;;
        node)
            bash scripts/install/install_node.sh
            ;;
        java)
            bash scripts/install/install_java.sh
            ;;
        go)
            bash scripts/install/install_go.sh
            ;;
        *)
            echo -e "${RED}Unknown language: $lang${NC}"
            exit 1
            ;;
    esac
}

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

# Function to install common tools
install_common_tools() {
    echo -e "${BLUE}Installing common tools...${NC}"
    bash scripts/install/install_git.sh
    bash scripts/install/install_docker.sh
    bash scripts/install/install_docker_hub.sh
    bash scripts/install/install_postman.sh
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
}

# Function to install AI/ML tools
install_ai_ml_tools() {
    echo -e "${BLUE}Installing AI/ML tools...${NC}"
    bash scripts/install/install_python.sh
    bash scripts/install/install_jupyter.sh
    bash scripts/install/install_ai_ml_packages.sh
}

# Function to uninstall AI/ML tools
uninstall_ai_ml_tools() {
    echo -e "${BLUE}Uninstalling AI/ML tools...${NC}"
    
    # Uninstall Python packages
    echo -e "${BLUE}Uninstalling Python packages...${NC}"
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
    
    # Uninstall Git
    echo -e "${BLUE}Uninstalling Git...${NC}"
    sudo apt-get purge -y git
    sudo apt-get autoremove -y
}

# Function to clean up after uninstallation
cleanup() {
    echo -e "${BLUE}Cleaning up...${NC}"
    sudo apt-get autoremove -y
    sudo apt-get clean
}

if [[ "$COMMAND" == "setup" ]]; then
    case "$SUBCOMMAND" in
        fullstack)
            if [[ -z "$3" ]]; then
                echo -e "${RED}Please specify a language (python, node, java, go)${NC}"
                exit 1
            fi
            echo -e "${BLUE}Setting up fullstack environment with $3...${NC}"
            install_language "$3"
            install_common_tools
            echo -e "${GREEN}✅ Fullstack environment setup completed!${NC}"
            ;;
        backend)
            if [[ -z "$3" ]]; then
                echo -e "${RED}Please specify a language (python, node, java, go)${NC}"
                exit 1
            fi
            echo -e "${BLUE}Setting up backend environment with $3...${NC}"
            install_language "$3"
            install_common_tools
            echo -e "${GREEN}✅ Backend environment setup completed!${NC}"
            ;;
        ai-ml)
            echo -e "${BLUE}Setting up AI & ML environment...${NC}"
            install_ai_ml_tools
            echo -e "${GREEN}✅ AI & ML environment setup completed!${NC}"
            ;;
        custom)
            echo -e "${YELLOW}Custom installation not implemented in CLI mode.${NC}"
            echo -e "${YELLOW}Please use the GUI mode for custom installation:${NC}"
            echo -e "${BLUE}brewdev gui${NC}"
            ;;
        *)
            echo -e "${RED}Unknown setup type: $SUBCOMMAND${NC}"
            show_help
            exit 1
            ;;
    esac
elif [[ "$COMMAND" == "uninstall" ]]; then
    # Confirm uninstallation
    echo -e "${YELLOW}Are you sure you want to uninstall the $SUBCOMMAND environment? (y/N)${NC}"
    read -r response
    if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo -e "${BLUE}Uninstallation cancelled.${NC}"
        exit 0
    fi

    case "$SUBCOMMAND" in
        fullstack)
            if [[ -z "$3" ]]; then
                echo -e "${RED}Please specify a language (python, node, java, go)${NC}"
                exit 1
            fi
            echo -e "${BLUE}Uninstalling fullstack environment with $3...${NC}"
            uninstall_language "$3"
            uninstall_common_tools
            cleanup
            echo -e "${GREEN}✅ Fullstack environment uninstallation completed!${NC}"
            ;;
        backend)
            if [[ -z "$3" ]]; then
                echo -e "${RED}Please specify a language (python, node, java, go)${NC}"
                exit 1
            fi
            echo -e "${BLUE}Uninstalling backend environment with $3...${NC}"
            uninstall_language "$3"
            uninstall_common_tools
            cleanup
            echo -e "${GREEN}✅ Backend environment uninstallation completed!${NC}"
            ;;
        ai-ml)
            echo -e "${BLUE}Uninstalling AI & ML environment...${NC}"
            uninstall_ai_ml_tools
            cleanup
            echo -e "${GREEN}✅ AI & ML environment uninstallation completed!${NC}"
            ;;
        custom)
            echo -e "${YELLOW}Custom uninstallation not implemented in CLI mode.${NC}"
            echo -e "${YELLOW}Please use the GUI mode for custom uninstallation:${NC}"
            echo -e "${BLUE}brewdev gui${NC}"
            ;;
        *)
            echo -e "${RED}Unknown uninstall type: $SUBCOMMAND${NC}"
            show_help
            exit 1
            ;;
    esac
elif [[ "$COMMAND" == "gui" ]]; then
    bash scripts/gui.sh
else
    echo -e "${RED}Unknown command: $COMMAND${NC}"
    show_help
    exit 1
fi
