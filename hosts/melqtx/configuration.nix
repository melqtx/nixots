





# hosts/melqtx/configuration.nix
{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "melqtx";
  networking.networkmanager.enable = true;

  # Time zone and locale
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system and Wayland
  services.xserver.enable = true;
  
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  
  # XDG Desktop Portal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  # Fonts
  fonts.packages = with pkgs; [
    font-awesome
    material-design-icons
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    dejavu_fonts
    liberation_ttf
  ];

  # Enable sound with PipeWire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define user account
  users.users.mel = {
    isNormalUser = true;
    description = "mel";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    firefox
    wget
    curl
  ];

  # Programs
  programs = {
    # Enable dconf for GTK apps
    dconf.enable = true;
  };

  # Services
  services = {
    # Enable dbus
    dbus.enable = true;
    
    # Enable gnome keyring
    gnome.gnome-keyring.enable = true;
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05";
}
