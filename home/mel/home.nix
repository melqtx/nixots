{ inputs, config, pkgs, lib, ... }:
let
  colors = import ../../shared/cols/forest.nix { };
  walltype = "image";
in
{
  # Basic user info
  home.username = "mel";
  home.homeDirectory = "/home/mel";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  # Cursor theme
  home.file.".icons/default".source = "${pkgs.phinger-cursors}/share/icons/phinger-cursors";
  
  # Wallpapers directory
  home.file.".wallpapers" = {
    source = ../../shared/wallpapers;
    recursive = true;
  };

  # GTK theming
  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-decoration-layout = "menu:";
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  # Qt theming
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  # Nixpkgs configuration
  nixpkgs.config = {
    allowUnfree = true;
    allowInsecure = true;
    allowBroken = true;
    allowUnfreePredicate = _: true;
  };

  # Essential packages
  home.packages = with pkgs; [
    # System utilities
    git
    wget
    curl
    killall
    brightnessctl
    playerctl
    grim
    slurp
    wl-clipboard
    swww
    rofi-wayland  # Use rofi-wayland instead of wofi for better compatibility
    dunst
    # Development
    neovim
    pavucontrol
    imv
    mpv
    nemo
    vesktop
    phinger-cursors
    papirus-icon-theme
    gnome-themes-extra  # For Adwaita theme
    font-awesome
    material-design-icons
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    kitty
    ghostty
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    wireplumber
    fastfetch
    pfetch
    neofetch
  ];

  # Fonts configuration
  fonts.fontconfig.enable = true;

  # Programs configuration
  programs = {
    # Configure rofi
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = "Arc-Dark";
    };
  };

  # Environment variables for proper theming
  home.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    QT_QPA_PLATFORMTHEME = "gtk2";
    QT_STYLE_OVERRIDE = "adwaita-dark";
  };

  # Import configurations
  imports = [
    # Colors/theming
    (import ../../shared/xresources.nix { inherit colors; })
    
    # UI components
    (import ./conf/ui/hyprland/default.nix { inherit config pkgs lib colors; })
    (import ./conf/ui/waybar/default.nix { inherit config pkgs lib colors; })
  ];
}
