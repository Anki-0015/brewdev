#!/bin/bash

# Function to display the main menu
show_main_menu() {
    dialog --clear --title "BrewDev Main Menu" \
        --menu "Use arrow keys to navigate and Enter to select:" \
        15 50 3 \
        1 "Install Software" \
        2 "Uninstall Software" \
        3 "Exit" 2>/tmp/main_menu_choice
}

# Function to display the install menu
show_install_menu() {
    dialog --clear --title "Install Software Menu" \
        --menu "Select a program to install:" \
        15 50 6 \
        1 "Install Docker" \
        2 "Install Node.js" \
        3 "Install PostgreSQL" \
        4 "Install Java (OpenJDK)" \
        5 "Install Go (Golang)" \
        6 "Back to Main Menu" 2>/tmp/install_menu_choice
}

# Function to display the uninstall menu
show_uninstall_menu() {
    dialog --clear --title "Uninstall Software Menu" \
        --menu "Select a program to uninstall:" \
        15 50 6 \
        1 "Uninstall Docker" \
        2 "Uninstall Node.js" \
        3 "Uninstall PostgreSQL" \
        4 "Uninstall Java (OpenJDK)" \
        5 "Uninstall Go (Golang)" \
        6 "Back to Main Menu" 2>/tmp/uninstall_menu_choice
}

# Function for installing Docker
install_docker() {
    sudo apt-get install -y docker.io
    dialog --msgbox "Docker has been installed!" 5 30
}

# Function for installing Node.js
install_nodejs() {
    sudo apt-get install -y nodejs npm
    dialog --msgbox "Node.js has been installed!" 5 30
}

# Function for installing PostgreSQL
install_postgresql() {
    sudo apt-get install -y postgresql postgresql-contrib
    dialog --msgbox "PostgreSQL has been installed!" 5 30
}

# Function for installing Java (OpenJDK)
install_java() {
    sudo apt-get install -y openjdk-11-jdk
    dialog --msgbox "Java (OpenJDK 11) has been installed!" 5 30
}

# Function for installing Go (Golang)
install_go() {
    sudo apt-get install -y golang
    dialog --msgbox "Go (Golang) has been installed!" 5 30
}

# Function to check if a package is installed
check_package_installed() {
    dpkg -l | grep -i "$1" > /dev/null
    return $?
}

# Function for uninstalling Docker
uninstall_docker() {
    sudo apt-get purge -y docker.io
    if ! check_package_installed "docker.io"; then
        dialog --msgbox "Docker has been uninstalled!" 5 30
    else
        dialog --msgbox "Docker could not be uninstalled!" 5 30
    fi
}

# Function for uninstalling Node.js
uninstall_nodejs() {
    sudo apt-get purge -y nodejs npm
    if ! check_package_installed "nodejs"; then
        dialog --msgbox "Node.js has been uninstalled!" 5 30
    else
        dialog --msgbox "Node.js could not be uninstalled!" 5 30
    fi
}

# Function for uninstalling PostgreSQL
uninstall_postgresql() {
    sudo apt-get purge -y postgresql postgresql-contrib
    if ! check_package_installed "postgresql"; then
        dialog --msgbox "PostgreSQL has been uninstalled!" 5 30
    else
        dialog --msgbox "PostgreSQL could not be uninstalled!" 5 30
    fi
}

# Function for uninstalling Java (OpenJDK)
uninstall_java() {
    sudo apt-get purge -y openjdk-11-jdk
    if ! check_package_installed "openjdk-11-jdk"; then
        dialog --msgbox "Java (OpenJDK 11) has been uninstalled!" 5 30
    else
        dialog --msgbox "Java (OpenJDK 11) could not be uninstalled!" 5 30
    fi
}

# Function for uninstalling Go (Golang)
uninstall_go() {
    # First try to remove it using apt-get
    if dpkg -l | grep -q golang-go; then
        sudo apt-get purge -y golang-go golang
        if ! check_package_installed "golang-go"; then
            dialog --msgbox "Go (Golang) has been uninstalled via apt-get!" 5 30
        else
            dialog --msgbox "Go (Golang) could not be uninstalled via apt-get!" 5 30
        fi
    else
        # If it was manually installed, remove the directory manually
        if [ -d "/usr/local/go" ]; then
            sudo rm -rf /usr/local/go
            sudo rm -f /usr/local/bin/go
            sudo rm -f /usr/local/bin/gofmt
            dialog --msgbox "Go (Golang) has been uninstalled manually!" 5 30
        else
            dialog --msgbox "Go (Golang) is not installed or could not be found!" 5 30
        fi
    fi
}

# Main loop to handle the main menu
while true; do
    show_main_menu
    main_menu_choice=$(< /tmp/main_menu_choice)

    # Check if user canceled the dialog (exit code 1)
    if [ $? -eq 1 ]; then
        echo "Dialog canceled or closed. Exiting..."
        break
    fi

    case $main_menu_choice in
        1)  # Install Software
            while true; do
                show_install_menu
                install_menu_choice=$(< /tmp/install_menu_choice)

                # Check if user canceled the dialog
                if [ $? -eq 1 ]; then
                    break
                fi

                case $install_menu_choice in
                    1) install_docker ;;
                    2) install_nodejs ;;
                    3) install_postgresql ;;
                    4) install_java ;;
                    5) install_go ;;
                    6) break ;;  # Back to Main Menu
                    *)
                        dialog --msgbox "Invalid choice, please try again." 5 30
                        ;;
                esac
            done
            ;;
        2)  # Uninstall Software
            while true; do
                show_uninstall_menu
                uninstall_menu_choice=$(< /tmp/uninstall_menu_choice)

                # Check if user canceled the dialog
                if [ $? -eq 1 ]; then
                    break
                fi

                case $uninstall_menu_choice in
                    1) uninstall_docker ;;
                    2) uninstall_nodejs ;;
                    3) uninstall_postgresql ;;
                    4) uninstall_java ;;
                    5) uninstall_go ;;
                    6) break ;;  # Back to Main Menu
                    *)
                        dialog --msgbox "Invalid choice, please try again." 5 30
                        ;;
                esac
            done
            ;;
        3)  # Exit
            break
            ;;
        *)
            dialog --msgbox "Invalid choice, please try again." 5 30
            ;;
    esac
done

clear
exit 0

