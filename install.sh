#!/bin/bash

echo "Welcome to the Install Menu!"
echo "Choose the software to install:"
echo "1) Install Docker"
echo "2) Install Node.js"
echo "3) Install Go"
echo "4) Install PostgreSQL"
echo "5) Install additional tools (curl, git, vim)"
echo "6) Install all software"
echo "7) Exit"
read -rp "Enter your choice: " choice

case "$choice" in
  1)
    echo "Installing Docker..."
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    ;;
  2)
    echo "Installing Node.js..."
    sudo apt install -y nodejs
    sudo apt install -y npm
    ;;
  3)
    echo "Installing Go..."
    sudo apt install -y golang-go
    ;;
  4)
    echo "Installing PostgreSQL..."
    sudo apt install -y postgresql postgresql-contrib
    ;;
  5)
    echo "Installing additional tools (curl, git, vim)..."
    sudo apt install -y curl git vim
    ;;
  6)
    echo "Installing all software..."
    sudo apt update
    sudo apt install -y docker.io nodejs npm golang-go postgresql postgresql-contrib curl git vim
    sudo systemctl start docker
    sudo systemctl enable docker
    ;;
  7)
    echo "Exiting..."
    exit 0
    ;;
  *)
    echo "Invalid choice. Exiting..."
    exit 1
    ;;
esac

# Verify installations (optional)
echo "Verifying installations..."
docker --version
node --version
npm --version
go version
psql --version

echo "Installation process completed!"

