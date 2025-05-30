{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    wget
    curl
    killall
    brightnessctl
    playerctl
    grim
    wl-clipboard
    swww
    rofi-wayland
    dunst
    
    zsh
    tmux
    kitty
    ghostty
    
    obsidian
    obs-studio
    flameshot
    peaclock
    vscodium
    neovim
    pavucontrol
    imv
    nwg-look
    mpv
    zathura
    nemo
    code-cursor
    vesktop
    
    tree
    vnstat
    fzf
    zoxide
    sesh
    fd
    fastfetch
    pfetch
    neofetch
    ripgrep
    
    bibata-cursors
    papirus-icon-theme
    gnome-themes-extra
    
    font-awesome
    material-design-icons
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    
    slurp
    redshift
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    wireplumber
  ];
}
