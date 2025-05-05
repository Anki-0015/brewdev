#!/bin/bash

echo "Welcome to BrewDev!"
echo "Choose an option:"
echo "1) Install software"
echo "2) Uninstall software"
echo "3) Exit"
read -rp "Enter choice: " choice

case "$choice" in
  1)
    ./install.sh
    ;;
  2)
    ./uninstall.sh
    ;;
  3)
    echo "Goodbye!"
    exit 0
    ;;
  *)
    echo "Invalid choice."
    ;;
esac

COMMAND=$1
SUBCOMMAND=$2
VERSION="0.0.1"

case "$COMMAND" in
  --help|-h)
    echo "Usage: brewdev [command] [subcommand]"
    echo
    echo "Commands:"
    echo "  setup fullstack     Install fullstack environment"
    echo "  setup frontend      Install frontend-only tools"
    echo "  setup backend       Install backend stack"
    echo
    echo "Options:"
    echo "  --help, -h          Show this help message"
    echo "  --version, -v       Show brewdev version"
    exit 0
    ;;
  --version|-v)
    echo "🍺 brewdev version $VERSION"
    exit 0
    ;;
esac

RED="\033[0;31m"
RESET="\033[0m"

if [[ "$COMMAND" == "setup" ]]; then
  if [[ "$SUBCOMMAND" == "fullstack" ]]; then
    bash scripts/setup_fullstack.sh
  else
    echo -e "${RED}Unknown setup type: $SUBCOMMAND${RESET}"
  fi
else
  echo -e "${RED}Unknown command: $COMMAND${RESET}"
fi
