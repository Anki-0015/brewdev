
# BrewDev

**BrewDev** is a lightweight CLI tool to set up fullstack development environments easily. It features a **menu-driven GUI installer** using `dialog` for a smoother and interactive experience.

---

## 🛠 Installation (GUI Menu)

To begin the setup, run:

```bash
---
curl -s https://raw.githubusercontent.com/ManikLakhanpal/brewdev/main/install.sh | bash

```
✅ This will launch a dialog-based GUI main menu with the following options:

* **Install Fullstack**: Installs and sets up the fullstack development environment.
* **Uninstall Fullstack**: Removes everything set up by BrewDev.
* **Exit**: Closes the installer.



## ⚠️ Prerequisite: `dialog`

The GUI requires the `dialog` package.

If not already installed, install it manually:

```bash
# Debian/Ubuntu
sudo apt-get update && sudo apt-get install -y dialog

# Red Hat/Fedora
sudo dnf install -y dialog

# macOS (via Homebrew)
brew install dialog
```

📦 On Debian-based systems, the installer will attempt to auto-install `dialog`.

---

## ⚙️ Manual Fullstack Setup

You can manually run the setup after installation with:

```bash
./brewdev.sh setup fullstack
```

This initializes both frontend and backend project structure.

---

## 📁 Project Structure

```
brewdev/
├── brewdev.sh                 # Main CLI tool
├── install.sh                 # GUI installer entry point
├── uninstall.sh               # (Optional) direct uninstall
├── scripts/
│   ├── gui.sh                 # GUI logic using dialog
│   ├── install_fullstack.sh   # Fullstack installation script
│   └── uninstall_fullstack.sh # Fullstack uninstallation script
```

---

## 🧰 Requirements

* Bash
* Git
* `dialog` (required for GUI)

---

## 🔄 Uninstallation

To uninstall via GUI:

```bash
curl -s https://raw.githubusercontent.com/ManikLakhanpal/brewdev/main/install.sh | bash
```

Then choose **"Uninstall Fullstack"** from the menu.

Or run directly:

```bash
./scripts/uninstall_fullstack.sh
```

---

## 🤝 Contributing

Pull requests are welcome! Please submit any ideas, improvements, or bug fixes.

---

## 📄 License

MIT License
© Ansh Kaushal
© Manik Lakhanpal
© Ankit
© Ketan Sharma

```
```
