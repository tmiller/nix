{ config, lib, pkgs, specialArgs, ... }:
{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.username = "tom";
  home.stateVersion = "22.11"; # Please read the comment before changing.

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
    nixd
    nixpkgs-fmt
    # nodejs_14
    nodejs
    nurl
    nushell
    obsidian
    ocaml
    openssl
    postgresql_15
    ripgrep
    rustup
    shellcheck
    yq
    zoom-us
  ];


    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tom/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
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

      # "conda/.condarc".text = ''
      #   changeps1: False
      # '';

      "nix/nix.conf".text = ''
        experimental-features = nix-command flakes
        keep-outputs = true
        keep-derivations = true
      '';

      # "k9s/skin.yml".source = ./programs/k9s/skin.yml;

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

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    eza     = import ../programs/eza.nix     { inherit config; };
    fish    = import ../programs/fish.nix    { inherit config pkgs; };
    fzf     = import ../programs/fzf.nix     { inherit config; };
    git     = import ../programs/git.nix     { inherit config; };
    gpg     = import ../programs/gpg         { inherit config; };
    neovim  = import ../programs/neovim.nix  { inherit config pkgs; };
    tmux    = import ../programs/tmux.nix    { inherit config pkgs; };
    vscode  = import ../programs/vscode.nix  { inherit config pkgs; };
    wezterm = import ../programs/wezterm.nix { inherit config; };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
