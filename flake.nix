{
  description = "NixOS configuration";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.nixos-hardware.url = "github:nixos/nixos-hardware/master";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.polymc.url = "github:PolyMC/PolyMC";

  outputs = { self, nixpkgs, nixos-hardware, home-manager, polymc, ... }: {
    nixosConfigurations."xps" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixos-hardware.nixosModules.dell-xps-13-9310
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.rdk = import ./home;
        }
        {
          nixpkgs.overlays = [
            polymc.overlay
          ];
          nixpkgs.config.allowUnfree = true;
          nix.registry.nixpkgs.flake = nixpkgs;
        }
      ];
    };
  };
}
