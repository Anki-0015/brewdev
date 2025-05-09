#!/bin/bash

# Define colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run this script as root (use sudo)${NC}"
    exit 1
fi

# Create installation directory
INSTALL_DIR="/usr/local/brewdev"
echo -e "${BLUE}Creating installation directory at $INSTALL_DIR...${NC}"
mkdir -p "$INSTALL_DIR"

# Clone the repository
echo -e "${BLUE}Cloning brewdev repository...${NC}"
git clone https://github.com/ManikLakhanpal/brewdev.git "$INSTALL_DIR"

# Make scripts executable
echo -e "${BLUE}Setting up permissions...${NC}"
chmod +x "$INSTALL_DIR/brewdev.sh"
chmod +x "$INSTALL_DIR/scripts/gui.sh"
chmod +x "$INSTALL_DIR/scripts/install/"*.sh

# Create symlink for system-wide access
echo -e "${BLUE}Creating system-wide symlink...${NC}"
ln -sf "$INSTALL_DIR/brewdev.sh" /usr/local/bin/brewdev

# Add to PATH for all users
echo -e "${BLUE}Adding to system PATH...${NC}"
if ! grep -q "export PATH=\"/usr/local/brewdev:\$PATH\"" /etc/profile; then
    echo 'export PATH="/usr/local/brewdev:$PATH"' >> /etc/profile
fi

# Create desktop entry
echo -e "${BLUE}Creating desktop entry...${NC}"
cat > /usr/share/applications/brewdev.desktop << EOL
[Desktop Entry]
Name=BrewDev
Comment=Development Environment Setup Tool
Exec=/usr/local/bin/brewdev gui
Terminal=true
Type=Application
Categories=Development;Utility;
EOL

# Update desktop database
update-desktop-database

echo -e "\n${GREEN}===========================================${NC}"
echo -e "${GREEN}===========================================${NC}\n"
echo -e "${GREEN}  🎉🎉🎉 🍺BREWDEV INSTALLED SUCCESSFULLY! 🎉🎉🎉${NC}"
echo -e "\n${GREEN}===========================================${NC}"
echo -e "${GREEN}===========================================${NC}"
echo -e "${GREEN}===========================================${NC}\n"

echo -e "${YELLOW}To start using brewdev:${NC}"
echo -e "1. Run ${BLUE}brewdev${NC} in terminal for CLI mode"
echo -e "2. Run ${BLUE}brewdev gui${NC} for GUI mode"
echo -e "3. Or find 'BrewDev' in your applications menu\n"

echo -e "${YELLOW}Note:${NC} You may need to log out and log back in for PATH changes to take effect."
