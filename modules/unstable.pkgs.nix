
{ config, lib, pkgs, pkgs-unstable, ... }:
{

  environment.systemPackages = with pkgs-unstable; [
        yazi
        ytfzf
        emacs
        yt-dlp
        mpv
        transmission_4-qt
        transmission_4

  ];
}
