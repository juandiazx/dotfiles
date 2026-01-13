# dotfiles

> Personal development environment setup for a fresh Ubuntu machine.

## What this repo does

-   Provides shell config, VS Code settings, and small utility scripts.
-   `bootstrap.sh` updates the system, installs a baseline toolset, runs all program setup scripts in `scripts/programs/`, links dotfiles, and applies the Caps Lock delay fix.

## Quick start

Clone, enter, make executable, and run (use SSH if you already have keys, otherwise HTTPS):

```
git clone git@github.com:juandiazx/dotfiles.git && cd dotfiles && chmod +x bootstrap.sh && ./bootstrap.sh
# or
git clone https://github.com/juandiazx/dotfiles.git && cd dotfiles && chmod +x bootstrap.sh && ./bootstrap.sh
```

This will install core packages plus: Docker, Go, Node (via nvm), Python tools, VS Code, and set up symlinks.

## Set up a new SSH key (if needed)

```
ssh-keygen -t ed25519 -C "your_email@example.com"
# Start agent
eval "$(ssh-agent -s)"
# Add key
ssh-add ~/.ssh/id_ed25519
# Secure permissions
chmod 600 ~/.ssh/id_ed25519
# Copy this to GitHub / other service
cat ~/.ssh/id_ed25519.pub
```

If re‑using existing keys, place them in `~/.ssh/`, fix perms (`chmod 600 <key>`), and run `ssh-add <key>`.

## After install

-   Open a new terminal (group changes like `docker` access need a new session or `newgrp docker`).
-   Verify tooling: `go version`, `docker --version`, `node --version`, `python3 --version`.
-   Ensure nvidia drivers, GPU, Secure Boot, Firewall, LUKS disk encryption are active

## Disclaimer

Opinionated and minimal. Adapt before use in production environments.
