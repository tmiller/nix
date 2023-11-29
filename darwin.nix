{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    docker
    inetutils
    raycast
    ruby_3_2
  ];
}
