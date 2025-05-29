{ config, pkgs, ... }: {
  # Common system-wide configurations
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Add common packages here
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
  ];
}
