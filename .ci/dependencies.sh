#!/bin/sh
set -eu

# Refresh package databases
pacman --sync --noconfirm --refresh

# Upgrade system
pacman --sync --noconfirm --sysupgrade

# Remove existing keys
rm -fr /etc/pacman.d/gnupg

# Init keystore
pacman-key --init

# Populate keystore
pacman-key --populate

# Install required packages
pacman --sync --noconfirm --needed archiso patch python python-jinja rdfind reflector

# Allow non-zero exit codes
set +e

# Configure mirrorlist
reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
