{ config, pkgs, lib, ... }:
{
  services = {
    xserver.enable = true;
    
    dbus.enable = true;
    
    gnome.gnome-keyring.enable = true;
    
    vnstat.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      settings = {
        Autologin = {
          Session = "hyprland";
          User = "mel";
        };
      };
    };
  };
}
