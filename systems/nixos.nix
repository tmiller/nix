{ config, lib, pkgs, ... }:
{
  home.homeDirectory = "/home/${config.home.username}";

  home.packages = with pkgs; [
    androidStudioPackages.beta
    appimage-run
    ctags
    dig
    efibootmgr
    evolution
    file
    gnucash
    google-cloud-sdk-extra
    google-cloud-sql-proxy
    gparted
    htop
    inetutils
    jetbrains.datagrip
    jetbrains.idea-ultimate
    jetbrains.phpstorm
    jetbrains.pycharm-professional
    jetbrains.webstorm
    libreoffice
    libreoffice-fresh
    libxml2
    livebook
    navicat
    navicat-desktop
    nvtop
    ruby
    signal-desktop
    slack
    spotify
    tdesktop
    xsel
    yubikey-manager
    yubikey-manager-qt
  ];

  xdg.configFile."autostart/gnome-keyring-ssh.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Hidden=true
  '';

  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
    enableSshSupport = true;
    sshKeys = [
      "7F7CF78A1316240108E5837CAC4A50B589E2CDEA"
      "F717FDE1B01A67A6CAE08303024B28E04483C320"
    ];
  };
}
