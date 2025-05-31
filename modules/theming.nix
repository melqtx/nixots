{ config, pkgs, lib, ... }:
{
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
    # Cursor theme
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Bibata-Modern-Ice";
    HYPRCURSOR_SIZE = "24";
    WLR_NO_HARDWARE_CURSORS = "1";
    
    # GTK/Qt theming
    GTK_THEME = "Adwaita:dark";
    QT_QPA_PLATFORMTHEME = "gtk2";
    QT_STYLE_OVERRIDE = "adwaita-dark";
  };
  
  # System packages for theming
  environment.systemPackages = with pkgs; [
    # Themes and icons
    gnome-themes-extra
    papirus-icon-theme
    bibata-cursors
    
    # Theme tools
    nwg-look
    dconf
  ];
  
  # Programs for theming
  programs.dconf.enable = true;
}
