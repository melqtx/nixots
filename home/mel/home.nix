{ inputs, config, pkgs, lib, ... }:

{
  home.username = "mel";
  home.homeDirectory = "/home/mel";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  
  imports = [
    ../shared/xresources.nix
    ./conf/wm/hyprland
    ./conf/wm/waybar.nix
    ./conf/term/ghostty.nix
    ./conf/term/kitty.nix
    ./conf/shell/zsh
    ./conf/shell/tmux
    ./conf/wm/dunst
    ./conf/wm/rofi
    ./conf/web/firefox.nix
    ./conf/web/brave.nix
    ./conf/web/qutebrowser.nix
    ./conf/web/vesktop.nix
    ./conf/utils/vscodium
    ./misc/neofetch.nix
    ./conf/shell/yazi/yazi.nix
  ];
}
