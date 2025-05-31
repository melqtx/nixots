{ config, pkgs, lib, ... }:
{
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
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
  
  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Bibata-Modern-Ice";
    HYPRCURSOR_SIZE = "24";
    XCURSOR_PATH = lib.mkForce "${pkgs.bibata-cursors}/share/icons:$HOME/.icons:$HOME/.local/share/icons";
  };
  
  fonts = {
    packages = with pkgs; [
      font-awesome
      material-design-icons
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      dejavu_fonts
      liberation_ttf
      bibata-cursors
      papirus-icon-theme
    ];
    
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
        sansSerif = [ "DejaVu Sans" ];
        serif = [ "DejaVu Serif" ];
      };
    };
  };
  
  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Bibata-Modern-Ice";
    HYPRCURSOR_SIZE = "24";
    WLR_NO_HARDWARE_CURSORS = "1";
    
    GTK_THEME = "Adwaita:dark";
    QT_QPA_PLATFORMTHEME = "gtk2";
    QT_STYLE_OVERRIDE = "adwaita-dark";
  };
  
  environment.systemPackages = with pkgs; [
    gnome-themes-extra
    papirus-icon-theme
    bibata-cursors
    
    nwg-look
    dconf
  ];
  
  programs.dconf.enable = true;
}
