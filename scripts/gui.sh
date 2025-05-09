#!/bin/bash

# Function to display the main menu
show_main_menu() {
    dialog --clear --title "BrewDev Main Menu" \
        --menu "Use arrow keys to navigate, Enter to select, or ESC to exit:" \
        15 50 5 \
        1 "Setup FullStack" \
        2 "Setup Backend" \
        3 "Setup AI & ML" \
        4 "Custom Installation" \
        5 "Uninstall Tools" \
        6 "Exit" 2>/tmp/main_menu_choice
    
    # Check if user pressed ESC or Cancel
    if [ $? -eq 1 ] || [ $? -eq 255 ]; then
        clear
        exit 0
    fi
}

# Function to display language selection menu
show_language_menu() {
    dialog --clear --title "Language Selection" \
        --menu "Choose your programming language (ESC to go back):" \
        15 50 5 \
        1 "Python" \
        2 "Node.js" \
        3 "Java" \
        4 "Go" \
        5 "Back" 2>/tmp/lang_choice
    
    # Check if user pressed ESC or Cancel
    if [ $? -eq 1 ] || [ $? -eq 255 ]; then
        return 1
    fi
    
    # Check if user selected "Back"
    if [ "$(cat /tmp/lang_choice)" = "5" ]; then
        return 1
    fi
}

# Function to display uninstall menu
show_uninstall_menu() {
    dialog --clear --title "Uninstall Tools" \
        --menu "Choose what to uninstall (ESC to go back):" \
        15 50 6 \
        1 "Uninstall FullStack" \
        2 "Uninstall Backend" \
        3 "Uninstall AI & ML" \
        4 "Custom Uninstall" \
        5 "Back to Main Menu" 2>/tmp/uninstall_choice
    
    # Check if user pressed ESC or Cancel
    if [ $? -eq 1 ] || [ $? -eq 255 ]; then
        return 1
    fi
}

# Function to show custom installation menu
show_custom_menu() {
    dialog --clear --title "Custom Installation" \
        --checklist "Select tools to install (Space to select, Enter to confirm, ESC to cancel):" \
        20 60 10 \
        1 "Python" off \
        2 "Node.js" off \
        3 "Java" off \
        4 "Go" off \
        5 "Git" off \
        6 "Docker" off \
        7 "Docker Hub" off \
        8 "Postman" off \
        9 "Jupyter Notebook" off \
        10 "PostgreSQL" off 2>/tmp/custom_choices
    
    # Check if user pressed ESC or Cancel
    if [ $? -eq 1 ] || [ $? -eq 255 ]; then
        return 1
    fi
}

# Function to show custom uninstall menu
show_custom_uninstall_menu() {
    dialog --clear --title "Custom Uninstall" \
        --checklist "Select tools to uninstall (Space to select, Enter to confirm, ESC to cancel):" \
        20 60 10 \
        1 "Python" off \
        2 "Node.js" off \
        3 "Java" off \
        4 "Go" off \
        5 "Git" off \
        6 "Docker" off \
        7 "Docker Hub" off \
        8 "Postman" off \
        9 "Jupyter Notebook" off \
        10 "PostgreSQL" off 2>/tmp/custom_uninstall_choices
    
    # Check if user pressed ESC or Cancel
    if [ $? -eq 1 ] || [ $? -eq 255 ]; then
        return 1
    fi
}

# Function to setup FullStack environment
setup_fullstack() {
    if ! show_language_menu; then
        return
    fi
    
    lang_choice=$(< /tmp/lang_choice)
    
    # Install selected language
    case $lang_choice in
        1)
            dialog --msgbox "Installing Python..." 5 30
            bash "$(dirname "$0")/install/install_python.sh"
            ;;
        2)
            dialog --msgbox "Installing Node.js..." 5 30
            bash "$(dirname "$0")/install/install_node.sh"
            ;;
        3)
            dialog --msgbox "Installing Java..." 5 30
            bash "$(dirname "$0")/install/install_java.sh"
            ;;
        4)
            dialog --msgbox "Installing Go..." 5 30
            bash "$(dirname "$0")/install/install_go.sh"
            ;;
    esac

    # Install common tools
    dialog --msgbox "Installing Git..." 5 30
    bash "$(dirname "$0")/install/install_git.sh"
    
    dialog --msgbox "Installing Docker..." 5 30
    bash "$(dirname "$0")/install/install_docker.sh"
    
    dialog --msgbox "Installing Docker Hub..." 5 30
    bash "$(dirname "$0")/install/install_docker_hub.sh"
    
    dialog --msgbox "Installing Postman..." 5 30
    bash "$(dirname "$0")/install/install_postman.sh"

    dialog --msgbox "✅ Fullstack environment setup complete!" 5 30
}

# Function to uninstall FullStack environment
uninstall_fullstack() {
    if ! show_language_menu; then
        return
    fi
    
    lang_choice=$(< /tmp/lang_choice)
    
    # Confirm uninstallation
    dialog --yesno "Are you sure you want to uninstall the FullStack environment? This will remove all installed tools and packages." 10 50
    if [ $? -eq 0 ]; then
        # Uninstall selected language
        case $lang_choice in
            1)
                dialog --msgbox "Uninstalling Python..." 5 30
                sudo apt-get purge -y python3 python3-pip python3-venv
                ;;
            2)
                dialog --msgbox "Uninstalling Node.js..." 5 30
                sudo apt-get purge -y nodejs npm
                ;;
            3)
                dialog --msgbox "Uninstalling Java..." 5 30
                sudo apt-get purge -y openjdk-17-jdk
                ;;
            4)
                dialog --msgbox "Uninstalling Go..." 5 30
                sudo apt-get purge -y golang-go golang
                if [ -d "/usr/local/go" ]; then
                    sudo rm -rf /usr/local/go
                    sudo rm -f /usr/local/bin/go
                    sudo rm -f /usr/local/bin/gofmt
                fi
                ;;
        esac

        # Uninstall common tools
        dialog --msgbox "Uninstalling Git..." 5 30
        sudo apt-get purge -y git
        
        dialog --msgbox "Uninstalling Docker..." 5 30
        sudo apt-get purge -y docker.io docker-ce docker-ce-cli containerd.io
        sudo rm -rf /var/lib/docker
        
        dialog --msgbox "Uninstalling Docker Hub..." 5 30
        sudo snap remove docker-hub
        
        dialog --msgbox "Uninstalling Postman..." 5 30
        sudo snap remove postman

        # Cleanup
        dialog --msgbox "Cleaning up..." 5 30
        sudo apt-get autoremove -y
        sudo apt-get clean

        dialog --msgbox "✅ Fullstack environment uninstallation complete!" 5 30
    else
        dialog --msgbox "Uninstallation cancelled." 5 30
    fi
}

# Function to setup Backend environment
setup_backend() {
    if ! show_language_menu; then
        return
    fi
    
    lang_choice=$(< /tmp/lang_choice)
    
    # Install selected language
    case $lang_choice in
        1)
            dialog --msgbox "Installing Python..." 5 30
            bash "$(dirname "$0")/install/install_python.sh"
            ;;
        2)
            dialog --msgbox "Installing Node.js..." 5 30
            bash "$(dirname "$0")/install/install_node.sh"
            ;;
        3)
            dialog --msgbox "Installing Java..." 5 30
            bash "$(dirname "$0")/install/install_java.sh"
            ;;
        4)
            dialog --msgbox "Installing Go..." 5 30
            bash "$(dirname "$0")/install/install_go.sh"
            ;;
    esac

    # Install backend tools
    dialog --msgbox "Installing Git..." 5 30
    bash "$(dirname "$0")/install/install_git.sh"
    
    dialog --msgbox "Installing Docker..." 5 30
    bash "$(dirname "$0")/install/install_docker.sh"
    
    dialog --msgbox "Installing Postman..." 5 30
    bash "$(dirname "$0")/install/install_postman.sh"

    dialog --msgbox "✅ Backend environment setup complete!" 5 30
}

# Function to uninstall Backend environment
uninstall_backend() {
    if ! show_language_menu; then
        return
    fi
    
    lang_choice=$(< /tmp/lang_choice)
    
    # Confirm uninstallation
    dialog --yesno "Are you sure you want to uninstall the Backend environment? This will remove all installed tools and packages." 10 50
    if [ $? -eq 0 ]; then
        # Uninstall selected language
        case $lang_choice in
            1)
                dialog --msgbox "Uninstalling Python..." 5 30
                sudo apt-get purge -y python3 python3-pip python3-venv
                ;;
            2)
                dialog --msgbox "Uninstalling Node.js..." 5 30
                sudo apt-get purge -y nodejs npm
                ;;
            3)
                dialog --msgbox "Uninstalling Java..." 5 30
                sudo apt-get purge -y openjdk-17-jdk
                ;;
            4)
                dialog --msgbox "Uninstalling Go..." 5 30
                sudo apt-get purge -y golang-go golang
                if [ -d "/usr/local/go" ]; then
                    sudo rm -rf /usr/local/go
                    sudo rm -f /usr/local/bin/go
                    sudo rm -f /usr/local/bin/gofmt
                fi
                ;;
        esac

        # Uninstall backend tools
        dialog --msgbox "Uninstalling Git..." 5 30
        sudo apt-get purge -y git
        
        dialog --msgbox "Uninstalling Docker..." 5 30
        sudo apt-get purge -y docker.io docker-ce docker-ce-cli containerd.io
        sudo rm -rf /var/lib/docker
        
        dialog --msgbox "Uninstalling Postman..." 5 30
        sudo snap remove postman

        # Cleanup
        dialog --msgbox "Cleaning up..." 5 30
        sudo apt-get autoremove -y
        sudo apt-get clean

        dialog --msgbox "✅ Backend environment uninstallation complete!" 5 30
    else
        dialog --msgbox "Uninstallation cancelled." 5 30
    fi
}

# Function to setup AI & ML environment
setup_ai_ml() {
    dialog --msgbox "Installing Python..." 5 30
    bash "$(dirname "$0")/install/install_python.sh"
    
    dialog --msgbox "Installing Jupyter Notebook..." 5 30
    bash "$(dirname "$0")/install/install_jupyter.sh"
    
    dialog --msgbox "Installing AI/ML packages..." 5 30
    bash "$(dirname "$0")/install/install_ai_ml_packages.sh"
    
    dialog --msgbox "Installing Git..." 5 30
    bash "$(dirname "$0")/install/install_git.sh"

    dialog --msgbox "✅ AI & ML environment setup complete!" 5 30
}

# Function to uninstall AI & ML environment
uninstall_ai_ml() {
    # Confirm uninstallation
    dialog --yesno "Are you sure you want to uninstall the AI & ML environment? This will remove all installed tools and packages." 10 50
    if [ $? -eq 0 ]; then
        # Uninstall Python packages
        dialog --msgbox "Uninstalling Python packages..." 5 30
        pip3 uninstall -y numpy scipy pandas matplotlib seaborn
        pip3 uninstall -y scikit-learn tensorflow keras
        pip3 uninstall -y torch torchvision torchaudio
        pip3 uninstall -y nltk spacy transformers
        pip3 uninstall -y plotly bokeh dash
        pip3 uninstall -y jupyter ipywidgets tqdm requests beautifulsoup4
        
        # Uninstall Jupyter
        dialog --msgbox "Uninstalling Jupyter..." 5 30
        pip3 uninstall -y notebook jupyterlab
        
        # Uninstall Python
        dialog --msgbox "Uninstalling Python..." 5 30
        sudo apt-get purge -y python3 python3-pip python3-venv
        
        # Uninstall Git
        dialog --msgbox "Uninstalling Git..." 5 30
        sudo apt-get purge -y git

        # Cleanup
        dialog --msgbox "Cleaning up..." 5 30
        sudo apt-get autoremove -y
        sudo apt-get clean

        dialog --msgbox "✅ AI & ML environment uninstallation complete!" 5 30
    else
        dialog --msgbox "Uninstallation cancelled." 5 30
    fi
}

# Function to handle custom installation
setup_custom() {
    if ! show_custom_menu; then
        return
    fi
    
    choices=$(< /tmp/custom_choices)
    
    for choice in $choices; do
        case $choice in
            1)
                dialog --msgbox "Installing Python..." 5 30
                bash "$(dirname "$0")/install/install_python.sh"
                ;;
            2)
                dialog --msgbox "Installing Node.js..." 5 30
                bash "$(dirname "$0")/install/install_node.sh"
                ;;
            3)
                dialog --msgbox "Installing Java..." 5 30
                bash "$(dirname "$0")/install/install_java.sh"
                ;;
            4)
                dialog --msgbox "Installing Go..." 5 30
                bash "$(dirname "$0")/install/install_go.sh"
                ;;
            5)
                dialog --msgbox "Installing Git..." 5 30
                bash "$(dirname "$0")/install/install_git.sh"
                ;;
            6)
                dialog --msgbox "Installing Docker..." 5 30
                bash "$(dirname "$0")/install/install_docker.sh"
                ;;
            7)
                dialog --msgbox "Installing Docker Hub..." 5 30
                bash "$(dirname "$0")/install/install_docker_hub.sh"
                ;;
            8)
                dialog --msgbox "Installing Postman..." 5 30
                bash "$(dirname "$0")/install/install_postman.sh"
                ;;
            9)
                dialog --msgbox "Installing Jupyter Notebook..." 5 30
                bash "$(dirname "$0")/install/install_jupyter.sh"
                ;;
            10)
                dialog --msgbox "Installing PostgreSQL..." 5 30
                bash "$(dirname "$0")/install/install_postgres.sh"
                ;;
        esac
    done

    dialog --msgbox "✅ Custom installation complete!" 5 30
}

# Function to handle custom uninstallation
uninstall_custom() {
    if ! show_custom_uninstall_menu; then
        return
    fi
    
    choices=$(< /tmp/custom_uninstall_choices)
    
    # Confirm uninstallation
    dialog --yesno "Are you sure you want to uninstall the selected tools? This will remove all selected tools and packages." 10 50
    if [ $? -eq 0 ]; then
        for choice in $choices; do
            case $choice in
                1)
                    dialog --msgbox "Uninstalling Python..." 5 30
                    sudo apt-get purge -y python3 python3-pip python3-venv
                    ;;
                2)
                    dialog --msgbox "Uninstalling Node.js..." 5 30
                    sudo apt-get purge -y nodejs npm
                    ;;
                3)
                    dialog --msgbox "Uninstalling Java..." 5 30
                    sudo apt-get purge -y openjdk-17-jdk
                    ;;
                4)
                    dialog --msgbox "Uninstalling Go..." 5 30
                    sudo apt-get purge -y golang-go golang
                    if [ -d "/usr/local/go" ]; then
                        sudo rm -rf /usr/local/go
                        sudo rm -f /usr/local/bin/go
                        sudo rm -f /usr/local/bin/gofmt
                    fi
                    ;;
                5)
                    dialog --msgbox "Uninstalling Git..." 5 30
                    sudo apt-get purge -y git
                    ;;
                6)
                    dialog --msgbox "Uninstalling Docker..." 5 30
                    sudo apt-get purge -y docker.io docker-ce docker-ce-cli containerd.io
                    sudo rm -rf /var/lib/docker
                    ;;
                7)
                    dialog --msgbox "Uninstalling Docker Hub..." 5 30
                    sudo snap remove docker-hub
                    ;;
                8)
                    dialog --msgbox "Uninstalling Postman..." 5 30
                    sudo snap remove postman
                    ;;
                9)
                    dialog --msgbox "Uninstalling Jupyter Notebook..." 5 30
                    pip3 uninstall -y notebook jupyterlab
                    ;;
                10)
                    dialog --msgbox "Uninstalling PostgreSQL..." 5 30
                    sudo apt-get purge -y postgresql postgresql-contrib
                    ;;
            esac
        done

        # Cleanup
        dialog --msgbox "Cleaning up..." 5 30
        sudo apt-get autoremove -y
        sudo apt-get clean

        dialog --msgbox "✅ Custom uninstallation complete!" 5 30
    else
        dialog --msgbox "Uninstallation cancelled." 5 30
    fi
}

# Function to handle uninstall menu
handle_uninstall_menu() {
    while true; do
        if ! show_uninstall_menu; then
            return
        fi
        
        uninstall_choice=$(< /tmp/uninstall_choice)
        
        case $uninstall_choice in
            1) uninstall_fullstack ;;
            2) uninstall_backend ;;
            3) uninstall_ai_ml ;;
            4) uninstall_custom ;;
            5) return ;;
            *)
                dialog --msgbox "Invalid choice, please try again." 5 30
                ;;
        esac
    done
}

# Main loop to handle the main menu
while true; do
    show_main_menu
    main_menu_choice=$(< /tmp/main_menu_choice)

    case $main_menu_choice in
        1) setup_fullstack ;;
        2) setup_backend ;;
        3) setup_ai_ml ;;
        4) setup_custom ;;
        5) handle_uninstall_menu ;;
        6) 
            clear
            exit 0
            ;;
        *)
            dialog --msgbox "Invalid choice, please try again." 5 30
            ;;
    esac
done

clear
exit 0

