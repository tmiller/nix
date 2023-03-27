{
  description = "Home Manager configuration of tom";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      username = "tom";

      mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit (args) system; };
        modules = [ (import ./home.nix) ];
        inherit (args) extraSpecialArgs;
      };
    in {
      homeConfigurations.nixos = mkHomeConfiguration {
        system = "aarch64-linux";
        extraSpecialArgs = {
          inherit username;
          homeDirectory = "/home/${username}";
        };
      };
      homeConfigurations.macbook = mkHomeConfiguration {
        system = "aarch64-darwin";
        extraSpecialArgs = {
          inherit username;
          homeDirectory = "/Users/${username}";
        };
      };
    };
}
