{
  description = "Home Manager configuration of tom";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      setupHomeManager = name: settings:
        home-manager.lib.homeManagerConfiguration {
          modules = [
            ./systems/all.nix
          ] ++ settings.modules;
          pkgs = import nixpkgs {
            system = settings.system;
            config =  {
              allowUnfree = true;
              permittedInsecurePackages = [
                "nodejs-14.21.3"
                "openssl-1.1.1v"
                "openssl-1.1.1w"
              ];
            };
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
                    url = "https://dn.navicat.com/download/navicat16-premium-en.AppImage";
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
        };

      configurations = {
        nixosArm = {
          system = "aarch64-linux";
          modules = [ ./systems/nixos.nix ];
        };
        nixos = {
          system = "x86_64-linux";
          modules = [ ./systems/nixos.nix ];
        };
        macos = {
          system = "aarch64-darwin";
          modules = [ ./systems/darwin.nix ];
        };
      };

    in
    {
      homeConfigurations = nixpkgs.lib.attrsets.mapAttrs setupHomeManager configurations;
    };
}
