#!/bin/sh

set -e

echo "🐹 Installing Go..."

# Get the latest Go version
LATEST_GO=$(curl -s https://go.dev/VERSION?m=text | grep -Eo '^go[0-9.]+')
GO_VERSION=${LATEST_GO#go}

echo "📦 Installing Go version $GO_VERSION..."

# Download and install Go
cd /tmp
wget -q https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz

# Remove any previous Go installation and install new one
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz

# Clean up
rm go${GO_VERSION}.linux-amd64.tar.gz

# Create Go workspace directories (POSIX compliant)
mkdir -p "$HOME/go/bin" "$HOME/go/pkg"

# Show installed Go version
echo "Go version: $(go version)"