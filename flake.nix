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

      pkgsForSystem = system: import nixpkgs { inherit system; };

      mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsForSystem args.system;
        modules = [ (import ./home.nix) ];
        extraSpecialArgs = { system = args.system; };
      };

    in {
      homeConfigurations.nixos = mkHomeConfiguration {
        system = "aarch64-linux";
      };
      homeConfigurations.macbook = mkHomeConfiguration {
        system = "aarch64-darwin";
      };
    };
}
