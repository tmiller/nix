{ config, lib, pkgs, ... }:

{
  home.homeDirectory = "/Users/${config.home.username}";

  home.packages = with pkgs; [
    docker
    inetutils
    raycast
  ];
}
