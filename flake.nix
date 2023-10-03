{
  description = "Home Manager configuration of tom";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs = {
      url = "github:nixos/nixpkgs/master";
    };
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
        config.permittedInsecurePackages = [
          "nodejs-14.21.3"
          "openssl-1.1.1v"
        ];
        overlays = [
          (self: super: {
            obsidian = super.obsidian.override {
              electron = self.electron_22;
            };
            google-cloud-sdk-extra = super.google-cloud-sdk.withExtraComponents [
              super.google-cloud-sdk.components.gke-gcloud-auth-plugin
            ];
            navicat = super.appimageTools.wrapType1 {
              name = "navicat";
              version = "16";

              src = super.fetchurl {
                url = "https://download3.navicat.com/download/navicat16-premium-en.AppImage";
                hash = "sha256-GiBSEle0xNvcU/dZGQgj7H3OMMyOho+LqjORCcFlMcM=";
              };
            };
            navicat-desktop = super.writeTextDir "share/applications/navicat16-premium.desktop" ''
              [Desktop Entry]
              Version=16
              Type=Application
              Name=Navicat
              Exec=navicat
              Icon=/home/pascal/Applications/icons/navicat-premium.png
              StartupWMClass=AppRun
            '';
          })
        ];
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
