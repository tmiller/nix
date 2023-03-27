# Nix development machines

## Instructions

```bash
# Install nix
sh <(curl -L https://nixos.org/nix/install)

# Configure Nix
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf

# Install and switch to Home Manager
nix run "${repo}#homeConfigurations.macbook.activationPackage"
home-manager switch --flake "github:tmiller/nix-dev-machine/v0.1.2#macbook"
```
