#!/bin/sh

echo "Setting up caps lock delay fix systemd service..."

CAPSLOCK_FIX_SCRIPT="$(pwd)/fix.sh"

# Make the script executable
chmod +x "$CAPSLOCK_FIX_SCRIPT"
echo "Made fix.sh executable"

# Create systemd user directory if it doesn't exist
mkdir -p ~/.config/systemd/user

# Create the systemd service file
cat > ~/.config/systemd/user/capsfix.service << EOF
[Unit]
Description=Fix Caps Lock delay on X session start
After=graphical.target

[Service]
ExecStart=$CAPSLOCK_FIX_SCRIPT
RemainAfterExit=true
Type=oneshot

[Install]
WantedBy=default.target
EOF

echo "Created systemd service file: ~/.config/systemd/user/capsfix.service"

# Enable the service
systemctl --user enable capsfix.service
systemctl --user start capsfix.service
echo "✓ Caps lock delay fix service enabled"