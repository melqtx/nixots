{ config, pkgs, lib, ... }:
{
  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = "greeter";
        };
      };
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
    
    networkmanager.enable = true;
    
    vnstat.enable = true;
  };
  
  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = false; # We use PipeWire
  };
  
  security = {
    rtkit.enable = true;
    polkit.enable = true;
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
}
