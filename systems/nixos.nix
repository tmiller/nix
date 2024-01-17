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
    jetbrains.rider
    jetbrains.webstorm
    libreoffice
    libreoffice-fresh
    libxml2
    livebook
    navicat
    navicat-desktop
    nvtop
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
    pinentryFlavor = "gnome3";
  };
}
