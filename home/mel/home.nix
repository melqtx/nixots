{ inputs, config, pkgs, lib, ... }:
let
  colors = import ../shared/cols/cat.nix {};
  walltype = "image";
in
{
  home.username = "mel";
  home.homeDirectory = "/home/mel";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  home.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    QT_QPA_PLATFORMTHEME = "gtk2";
    QT_STYLE_OVERRIDE = "adwaita-dark";
    
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Bibata-Modern-Ice";
    HYPRCURSOR_SIZE = "24";
    
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-decoration-layout = "menu:";
      gtk-cursor-theme-name = "Bibata-Modern-Ice";
      gtk-cursor-theme-size = 24;
    };
    gtk4.extraConfig = {
      gtk-cursor-theme-name = "Bibata-Modern-Ice";
      gtk-cursor-theme-size = 24;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowInsecure = true;
    allowBroken = true;
    allowUnfreePredicate = _: true;
  };

  home.packages = with pkgs; [
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
    rofi-wayland
    dunst
    zsh
    obsidian
    obs-studio
    tmux
    flameshot
    dunst
    vscodium
    neovim
    pavucontrol
    imv
    nwg-look
    mpv
    zathura
    tree
    vnstat
    nemo
    code-cursor
    vesktop
    fzf
    zoxide
    sesh
    fd
    bibata-cursors
    papirus-icon-theme
    gnome-themes-extra
    
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
    ripgrep
  ];

  fonts.fontconfig.enable = true;

 programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  imports = [
    (import ../shared/xresources.nix { inherit colors; })

    (import ./conf/ui/hyprland/default.nix { inherit config pkgs lib colors; })
    #(import ./conf/ui/waybar/default.nix { inherit config lib pkgs hyprland colors; })
    (import ./conf/ui/waybar/default.nix { inherit config lib pkgs colors; hyprland = inputs.hyprland; })


    (import ./conf/term/kitty/default.nix { inherit pkgs colors; })
    # Shell
    (import ./conf/shell/zsh/default.nix { inherit config colors pkgs lib; })
    (import ./conf/shell/tmux/default.nix { inherit pkgs; })
    (import ./conf/utils/dunst/default.nix { inherit colors pkgs; })

    (import ./conf/utils/rofi/default.nix { inherit config pkgs colors; })
    (import ./conf/browsers/firefox/default.nix { inherit colors pkgs; })
    (import ./misc/neofetch.nix { inherit config colors; })
    
    (import ./conf/browsers/brave/default.nix { inherit pkgs; })
    (import ./conf/editors/vscodium/default.nix { inherit pkgs colors; })
  ];
}
