{ config, lib, pkgs, ... }:

let
  gpgPkg = config.programs.gpg.package;
in
{
  home.homeDirectory = "/Users/${config.home.username}";

  # nix.settings = {
  #   builders = [ "ssh-ng://remote-builder x86_64-linux" ];
  # };

  home.packages = with pkgs; [
    docker
    inetutils
    raycast
  ];

  programs.fish.interactiveShellInit = ''
    set -gx SSH_AUTH_SOCK (${gpgPkg}/bin/gpgconf --list-dirs agent-ssh-socket)
  '';
}
