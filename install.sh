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
cp "$PWD"/pp-enhancer.service /etc/systemd/system
cp "$PWD"/pp-enhancer /usr/local/bin
cp "$PWD"/pp-enhancer.ini /etc

# Set permissions
chown root:root /usr/local/bin/pp-enhancer /etc/systemd/system/pp-enhancer.service /etc/pp-enhancer.ini
chmod 655 /usr/local/bin/pp-enhancer /etc/systemd/system/pp-enhancer.service /etc/pp-enhancer.ini
chmod +x /usr/local/bin/pp-enhancer

# Enable systemd service
systemctl enable --now pp-enhancer.service