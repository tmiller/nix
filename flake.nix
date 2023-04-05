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
      lib = nixpkgs.lib;

      isDarwin = system: (lib.strings.hasSuffix "-darwin" system);

      loadNixpkgs = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration rec {
        pkgs = loadNixpkgs args.system;
        modules = [ (import ./home.nix) ];
          extraSpecialArgs = {
            inherit username;
            inherit (args) homeDirectory;
            isDarwin = isDarwin args.system;
          };
      };
    in {
      homeConfigurations.nixosArm = mkHomeConfiguration {
        system = "aarch64-linux";
        homeDirectory = "/home/${username}";
      };
      homeConfigurations.nixos = mkHomeConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/${username}";
      };
      homeConfigurations.macos = mkHomeConfiguration {
        system = "aarch64-darwin";
        homeDirectory = "/Users/${username}";
      };
    };
}
