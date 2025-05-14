# 🍺 BrewDev

BrewDev is a powerful development environment setup tool that helps you quickly set up and manage your development environment on Linux systems.

## Features

- 🚀 Quick setup of development environments
- 🛠️ Multiple environment types:
  - FullStack
  - Backend
  - AI & ML
  - Custom installations
- 🔄 Easy uninstallation of tools
- 🖥️ Both CLI and GUI interfaces
- 🎨 Color-coded output for better visibility
- 🔒 Safe installation and uninstallation processes

## Prerequisites

- Linux operating system
- Git
- Sudo privileges

## Installation

1. Download the installation script:
```bash
wget https://raw.githubusercontent.com/ManikLakhanpal/brewdev/main/install.sh
```

2. Make the installation script executable:
```bash
chmod +x install.sh
```

3. Run the installation script with sudo:
```bash
sudo ./install.sh
```

The script will:
- Create the installation directory at `/usr/local/brewdev`
- Clone the repository
- Set up proper permissions
- Create system-wide symlinks
- Add brewdev to the system PATH
- Create a desktop entry (if using GUI)

## Usage

### CLI Mode

BrewDev can be used in two ways:

1. **Command Line Interface (CLI)**:
```bash
# Install fullstack environment with Python
brewdev setup fullstack python

# Install backend environment with Node.js
brewdev setup backend node

# Install AI & ML environment
brewdev setup ai-ml

# Custom installation
brewdev setup custom
```

2. **Graphical User Interface (GUI)**:
```bash
brewdev gui
```

### Available Commands

```bash
brewdev setup [type] [language]    # Install development environment
brewdev uninstall [type] [lang]   # Uninstall development environment
brewdev gui                       # Run the GUI menu
brewdev --help                    # Show help message
brewdev --version                 # Show version information
```

### Setup Types

- `fullstack`: Install fullstack environment
- `backend`: Install backend environment
- `ai-ml`: Install AI & ML environment
- `custom`: Custom installation

### Languages (for fullstack/backend)

- `python`: Python
- `node`: Node.js
- `java`: Java
- `go`: Go

## Post-Installation

After installation, you might need to:

1. Log out and log back in for PATH changes to take effect, or
2. Run the following command:
```bash
source /etc/profile
```

## Verification

To verify the installation:
```bash
brewdev --version
```

## Uninstallation

To uninstall tools, you can use either:

1. **CLI Mode**:
```bash
brewdev uninstall fullstack python
brewdev uninstall backend node
brewdev uninstall ai-ml
```

2. **GUI Mode**:
```bash
brewdev gui
```
Then select "Uninstall Tools" from the main menu.

## Troubleshooting

1. If you get a "command not found" error after installation:
   - Log out and log back in
   - Or run `source /etc/profile`

2. If you need to install Git first:
```bash
sudo apt-get update
sudo apt-get install git
```

3. For different Linux distributions:
   - Modify the installation commands to use your package manager
   - For RHEL/CentOS: use `yum`
   - For Fedora: use `dnf`

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

Manik Lakhanpal, Ankit Bansal, Ketan Sharma, Ansh Kaushal

## Support

If you encounter any issues or have questions, please open an issue on GitHub.
