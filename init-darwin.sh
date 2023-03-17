#!/bin/sh

# Install Nix
sh <(curl -L https://nixos.org/nix/install)

# Configure Nix
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' > ~/.config/nix/nix.conf
