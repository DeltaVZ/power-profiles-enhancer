#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

DIR="/usr/local/bin"

if [ ! -d "$DIR" ]; then
  echo "$DIRECTORY does not exist..."
  echo "Creating $DIR"
  mkdir -p $DIR
fi

# Copy files
cp "$PWD"/power-profiles-enhancer.service /etc/systemd/system
cp "$PWD"/power-profiles-enhancer /usr/local/bin
cp "$PWD"/power-profiles-enhancer.ini /etc

# Set permissions
chown root:root /usr/local/bin/power-profiles-enhancer /etc/systemd/system/power-profiles-enhancer.service /etc/power-profiles-enhancer.ini
chmod 655 /usr/local/bin/power-profiles-enhancer /etc/systemd/system/power-profiles-enhancer.service /etc/power-profiles-enhancer.ini
chmod +x /usr/local/bin/power-profiles-enhancer

# Enable systemd service
systemctl enable --now power-profiles-enhancer.service