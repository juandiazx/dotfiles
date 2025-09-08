#!/bin/sh

set -e

echo "🐍 Installing Python and related tools..."

# Install Python and essential packages
sudo apt update
sudo apt install -y \
    python3 \
    python3-pip \
    python3-dev \
    python3-venv

echo "✅ Python environment installed successfully!"
echo "Python version: $(python3 --version)"
echo "Pip version: $(pip3 --version)"