#!/bin/sh
set -eu

# Refresh package databases
pacman --sync --noconfirm --refresh

# Upgrade system
pacman --sync --noconfirm --sysupgrade

# Install required packages
pacman --sync --noconfirm --needed archiso patch python python-jinja rdfind
