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
    SSH_AUTH_SOCK              = "$(${pkgs.gnupg}/bin/gpgconf --list-dirs agent-ssh-socket)";
    NIXOS_OZONE_WL             = "1";
    USE_GKE_GCLOUD_AUTH_PLUGIN = "true";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.cargo/bin"
    "${config.home.homeDirectory}/sdk/flutter/bin"
  ];

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
