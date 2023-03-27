# Nix development machines

## Instructions

```bash
# Install nix
sh <(curl -L https://nixos.org/nix/install)

# Configure Nix
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf

# Install and switch to Home Manager
nix run "github:tmiller/nix/v1.0.0#homeConfigurations.macos.activationPackage"
home-manager switch --flake "github:tmiller/nix/v1.0.0#macos"
```
