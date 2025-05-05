#!/bin/bash



echo "Choose what to uninstall:"

echo "1) Full stack environment"

echo "2) Docker"

echo "3) Node.js"

echo "4) Go"

echo "5) PostgreSQL"

echo "6) Exit"

read -rp "Enter choice: " choice



case "$choice" in

  1)

    ./scripts/uninstall_fullstack.sh

    ;;

  2)

    sudo apt purge -y docker docker-engine docker.io containerd runc

    ;;

  3)

    sudo apt purge -y nodejs npm

    ;;

  4)

    sudo apt purge -y golang-go

    ;;

  5)

    sudo apt purge -y postgresql postgresql-contrib

    ;;

  6)

    echo "Uninstallation cancelled."

    exit 0

    ;;

  *)

    echo "Invalid choice."

    ;;

esac
