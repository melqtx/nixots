{
  description = "NixOS configuration flake";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nur = {
      url = "github:nix-community/NUR";
    };
  };
  
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, hyprland, nur, ... }@inputs: {
    nixosConfigurations = {
      melqtx = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit inputs;
          pkgs-unstable = import nixpkgs-unstable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        }; 
        modules = [
          ./hosts/melqtx/configuration.nix
          
          # NUR overlay
          ({ config, pkgs, ... }: {
            nixpkgs.overlays = [
              nur.overlays.default
            ];
          })
          
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { 
              inherit inputs; 
              hyprland = inputs.hyprland;
              # Also pass unstable packages to home-manager
              pkgs-unstable = import nixpkgs-unstable {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
            }; 
            home-manager.users.mel = import ./home/mel/home.nix;
          }
        ];
      };
    };
  };
}
