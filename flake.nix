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
        extraSpecialArgs = {
          inherit username;
          inherit (args) homeDirectory;
        };
      };
    in {
      homeConfigurations.nixos = mkHomeConfiguration {
        system = "aarch64-linux";
        homeDirectory = "/home/${username}";
      };
      homeConfigurations.macbook = mkHomeConfiguration {
        system = "aarch64-darwin";
        homeDirectory = "/Users/${username}";
      };
    };
}
