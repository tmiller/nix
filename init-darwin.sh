#!/bin/sh

repo="github:tmiller/nix-dev-machine"

# Install Nix
sh <(curl -L https://nixos.org/nix/install)

# Configure Nix
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf

nix run "${repo}#homeConfigurations.tom.activationPackage"
home-manager switch --flake "${repo}#tom"
