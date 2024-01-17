{ config, lib, pkgs, ... }:

let
  gpgPkg = config.programs.gpg.package;
in
{
  home.homeDirectory = "/Users/${config.home.username}";

  home.packages = with pkgs; [
    docker
    inetutils
    raycast
  ];

  programs.fish.interactiveShellInit = ''
    set -gx SSH_AUTH_SOCK (${gpgPkg}/bin/gpgconf --list-dirs agent-ssh-socket)
  '';
}
