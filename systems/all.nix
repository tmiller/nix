{ config, lib, pkgs, specialArgs, ... }:
{
  home.stateVersion = "22.11";

  home.username = "tom";

  # Look up better patterns for this.
  imports = [
    ../programs/eza
    ../programs/fish
    ../programs/fzf
    ../programs/git
    ../programs/gpg
    ../programs/neovim
    ../programs/tmux
    ../programs/vscode
    ../programs/wezterm
  ];

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    argo
    argocd
    attic
    awscli2
    bat
    cachix
    coreutils
    csvq
    cue
    devbox
    discord
    fd
    flyway
    gnumake
    go
    jq
    jwt-cli
    k9s
    kubectl
    kubernetes-helm
    kubie
    ldns # supplies drill replacement for dig
    liquibase
    mtr
    mysql
    nickel
    nixd
    nixpkgs-fmt
    nodejs
    # nodejs_14
    nurl
    nushell
    obsidian
    ocaml
    openssl
    postgresql_15
    ripgrep
    rustup
    shellcheck
    unzip
    yq
    zip
    zoom-us
  ];


  home.sessionVariables = {
    PAGER                      = "${pkgs.less}/bin/less";
    LESS                       = "-ingFXRS";
    GOPATH                     = config.home.homeDirectory;
    DOCKER_SCAN_SUGGEST        = "false";
    NPM_CONFIG_USERCONFIG      = "${config.xdg.configHome}/npm/config";
    NPM_CONFIG_CACHE           = "${config.xdg.cacheHome}/npm";
    NPM_CONFIG_PREFIX          = "${config.xdg.dataHome}/npm";
    NIXOS_OZONE_WL             = "1";
    USE_GKE_GCLOUD_AUTH_PLUGIN = "true";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.cargo/bin"
    "${config.home.homeDirectory}/sdk/flutter/bin"
  ];

  gpg-agent = {
    sshKeys = [
      "7F7CF78A1316240108E5837CAC4A50B589E2CDEA"
      "F717FDE1B01A67A6CAE08303024B28E04483C320"
    ];
    enable = true;
    enableExtraSocket = true;
    enableSshSupport = true;
  };

  xdg = {
    enable = true;
    configFile = {
      "nix/nix.conf".text = ''
        experimental-features = nix-command flakes
        keep-outputs = true
        keep-derivations = true
      '';

      "nixpkgs/config.nix".text = ''
        {
          permittedInsecurePackages = [
            "nodejs-14.21.3"
          ];
          allowUnfree = true;
        }
      '';
    };
  };

}
