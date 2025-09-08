#!/bin/sh

set -e

# Script paths
SYMLINK_SCRIPT="./scripts/symlink.sh"
CAPSLOCK_SETUP_SCRIPT="./scripts/capslock-delay-fix/setup.sh"

# Update Ubuntu and get standard repository programs
sudo apt update && sudo apt full-upgrade -y

install() {
  command -v "$1" >/dev/null 2>&1

  if [ $? -ne 0 ]; then
    echo "Installing: $1..."
    sudo apt install -y "$1"
  else
    echo "Already installed: $1"
  fi
}

# Basics
install curl
install build-essential 
install file
install git
install software-properties-common
install apt-transport-https
install nmap
install tree
install unzip
install wget
install grep
install tmux
install net-tools
install inxi

# Run all scripts in programs/
for f in scripts/programs/*.sh; do sh "$f" -H; done

# Ensure symlink.sh is executable
echo "Linking dotfiles (including VS Code settings)..."
chmod +x "$SYMLINK_SCRIPT"
"$SYMLINK_SCRIPT"

# Set up caps lock delay fix
chmod +x "$CAPSLOCK_SETUP_SCRIPT"
"$CAPSLOCK_SETUP_SCRIPT"

# Get all upgrades
sudo apt upgrade -y
sudo apt autoremove -y