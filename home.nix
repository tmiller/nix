{ config, lib, pkgs, specialArgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = { inherit (specialArgs) username homeDirectory; };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    argocd
    awscli
    bat
    cue
    discord
    fd
    go
    jq
    k9s
    kubectl
    kubernetes-helm
    kubie
    nixpkgs-fmt
    nodejs
    nurl
    nushell
    obsidian
    ocaml
    ripgrep
    zoom-us
  ] ++ lib.lists.optionals (!specialArgs.isDarwin) [
    (google-cloud-sdk.withExtraComponents [
      google-cloud-sdk.components.gke-gcloud-auth-plugin
    ])
    dig
    efibootmgr
    evolution
    gparted
    htop
    jetbrains.datagrip
    jetbrains.phpstorm
    jetbrains.pycharm-professional
    nvtop
    signal-desktop
    slack
    spotify
    tdesktop
    xsel
    yubikey-manager
    yubikey-manager-qt
  ] ++ lib.lists.optionals specialArgs.isDarwin [
    docker
    raycast
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

  xdg = {
    enable = true;
    configFile = {
      "autostart/gnome-keyring-ssh.desktop" = lib.mkIf (!specialArgs.isDarwin) {
        text = ''
          [Desktop Entry]
          Type=Application
          Hidden=true
        '';
      };

      "conda/.condarc".text = ''
        changeps1: False
      '';

      "fish/conf.d/conda.fish" = lib.mkIf specialArgs.isDarwin {
        text = lib.mkIf specialArgs.isDarwin ''
          eval /opt/homebrew/bin/conda "shell.fish" "hook" $argv | source
        '';
      };

      "nix/nix.conf".text = ''
        experimental-features = nix-command flakes
      '';

      # "k9s/skin.yml".source = ./programs/k9s/skin.yml;

      "nixpkgs/config.nix".text = ''
        {
          allowUnfree = true;
        }
      '';
    };
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    git     = import ./programs/git.nix     { inherit config; };
    neovim  = import ./programs/neovim.nix  { inherit config pkgs; };
    tmux    = import ./programs/tmux.nix    { inherit config pkgs; };
    gpg     = import ./programs/gpg         { inherit config; };
    fish    = import ./programs/fish.nix    { inherit config pkgs lib specialArgs; };
    fzf     = import ./programs/fzf.nix     { inherit config; };
    exa     = import ./programs/exa.nix     { inherit config; };
    wezterm = import ./programs/wezterm.nix { inherit config specialArgs; };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  services = {
    gpg-agent = lib.mkIf (!specialArgs.isDarwin) {
      enable = true;
      enableExtraSocket = true;
      enableSshSupport = true;
      sshKeys = [
        "7F7CF78A1316240108E5837CAC4A50B589E2CDEA"
        "F717FDE1B01A67A6CAE08303024B28E04483C320"
      ];
    };
  };
}
