{ config, pkgs, ... }:
{
  imports = [
    ./service.nix
    ./notifications.nix
  ];
}

