
{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    pywal16
    pywalfox-native
  ];

}
