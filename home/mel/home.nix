{ inputs, config, pkgs, lib, ... }:

{
  home.username = "mel";
  home.homeDirectory = "/home/mel";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  
  imports = [
    ../shared/xresources.nix
    ./conf/ui/hyprland
    ./conf/ui/waybar
    ./conf/term/ghostty
    ./conf/term/kitty
    ./conf/shell/zsh
    ./conf/shell/tmux
    ./conf/utils/dunst
    ./conf/utils/rofi
    ./conf/web/firefox.nix
    ./conf/web/brave.nix
    ./conf/web/qutebrowser.nix
    ./conf/web/vesktop.nix
    ./conf/editors/vscodium
    ./misc/neofetch.nix
  ];
}
