{ config, pkgs, lib, ... }:
{
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-sddm-corners";
    };
    
    # Audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    
    blueman.enable = true;
    vnstat.enable = true;
  };
  
    services.pulseaudio.enable = false; # We use PipeWire
  hardware = {
    bluetooth.enable = true;
  };
  
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.sddm.enableGnomeKeyring = true;
  };
  
  programs = {
    hyprland.enable = true;
    thunar.enable = true; # File manager
    
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
  
  environment.systemPackages = with pkgs; [
    (catppuccin-sddm-corners.override {
    })
  ];
  
  # Fix cursor theme system-wide
  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
}
