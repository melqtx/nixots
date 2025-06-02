{ inputs, config, pkgs, lib, ... }:
let
  colors = import ../../home/shared/cols {};
in
{
  imports = [
    ./hardware-configuration.nix
    ./modules/networking.nix
    ./modules/pkgs.nix
    ./modules/unstable.pkgs.nix 
    ./modules/desktop.nix
    ./modules/theming.nix
    ./modules/samba.nix
    ./modules/ssh.nix
  ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking.hostName = "melqtx";
  networking.networkmanager.enable = true;
  
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";
  
  services.xserver.enable = true;
  
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };
  
  fonts.packages = with pkgs; [
    font-awesome
    material-design-icons
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    dejavu_fonts
    liberation_ttf
    bibata-cursors
  ];
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
  
  programs = {
    dconf.enable = true;
    zsh.enable = true;
    zoxide.enable = true;
  };
  
  services.vnstat.enable = true;
  
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  
  users.users.mel = {
    isNormalUser = true;
    description = "mel";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
  };
  
  environment.systemPackages = with pkgs; [
    vim
    git
    firefox
    wget
    curl
  ];
  
  services = {
    dbus.enable = true;
    gnome.gnome-keyring.enable = true;
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nixpkgs.config.allowUnfree = true;
  
  system.stateVersion = "24.05";
}
