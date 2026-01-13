#!/bin/sh

set -e

# Script paths
SYMLINK_SCRIPT="./scripts/symlink.sh"

# Update Ubuntu and get standard repository programs
sudo apt update && sudo apt full-upgrade -y

install() {
  if dpkg -s "$1" >/dev/null 2>&1; then
    echo "Already installed: $1"
  else
    echo "Installing: $1..."
    sudo apt install -y "$1"
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
install unattended-upgrades

# Enable security updates only
sudo dpkg-reconfigure --priority=low unattended-upgrades

# Optional: Ensure only security updates are installed automatically
sudo tee /etc/apt/apt.conf.d/50unattended-upgrades > /dev/null <<EOF
Unattended-Upgrade::Allowed-Origins {
        "\${distro_id}:\${distro_codename}-security";
};
Unattended-Upgrade::Automatic-Reboot "false";
EOF

# Optional: Enable daily timer (systemd) for unattended-upgrades
sudo systemctl enable --now unattended-upgrades

# Run all scripts in programs/
for f in scripts/programs/*.sh; do sh "$f" -H; done

# Ensure symlink.sh is executable
echo "Linking dotfiles (including VS Code settings)..."
chmod +x "$SYMLINK_SCRIPT"
"$SYMLINK_SCRIPT"

# Get all upgrades
sudo apt upgrade -y
sudo apt autoremove -y