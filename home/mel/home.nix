{ inputs, config, pkgs, lib, ... }:
let
  colors = import ../shared/cols/horizon.nix {};
  walltype = "image";
in

{
  home.username = "mel";
  home.homeDirectory = "/home/mel";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;


  imports = [
    
    (import ../shared/xresources.nix { inherit colors; })
    (import ./conf/ui/hyprland/default.nix { inherit config pkgs lib colors; })
    (import ./conf/ui/waybar/default.nix { inherit config lib pkgs colors; hyprland = inputs.hyprland; })
    (import ./conf/term/ghostty/default.nix { inherit pkgs colors; })
    (import ./conf/term/kitty/default.nix { inherit pkgs colors; })
    (import ./conf/shell/zsh/default.nix { inherit config colors pkgs lib; })
    (import ./conf/shell/tmux/default.nix { inherit pkgs; })
    (import ./conf/utils/dunst/default.nix { inherit colors pkgs; })
    (import ./conf/utils/rofi/default.nix { inherit config pkgs colors; })
    (import ./conf/browsers/firefox/default.nix { inherit colors pkgs; })
    (import ./misc/neofetch.nix { inherit config colors; })
    (import ./conf/browsers/brave/default.nix { inherit pkgs; })
    (import ./conf/editors/vscodium/default.nix { inherit pkgs colors; })
    (import ./conf/web/vesktop.nix)
  ];
  
  
}
