#!/bin/sh

set -e

echo "🟢 Installing Node.js ecosystem..."

# Install NVM (Node Version Manager)
echo "📦 Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Source nvm script to use it immediately
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install latest LTS Node.js
echo "📦 Installing Node.js LTS..."
nvm install --lts
nvm use --lts
nvm alias default lts/*

# Update npm to latest version
echo "📦 Updating NPM..."
npm install -g npm@latest

# Install essential global packages only
echo "📦 Installing essential Node.js packages..."
npm install -g \
    yarn \
    typescript \
    nodemon \
    eslint \
    prettier

echo "✅ Node.js ecosystem installed successfully!"
echo "Node.js version: $(node --version)"
echo "NPM version: $(npm --version)"
echo "Yarn version: $(yarn --version)"

# Show available Node versions
echo "📋 Available Node.js versions:"
nvm ls

echo "🚀 You can switch Node versions with 'nvm use <version>'"