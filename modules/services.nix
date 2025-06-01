{ config, pkgs, lib, ... }:
{
  services = {
    xserver.enable = true;
    
    dbus.enable = true;
    
    gnome.gnome-keyring.enable = true;

{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;  
      PermitRootLogin = "no";         
    };
  };
  
  networking.firewall.allowedTCPPorts = [ 22 ];
}
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
