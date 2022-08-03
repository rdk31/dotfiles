{
  description = "NixOS configuration";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.05";
  inputs.nixos-hardware.url = "github:nixos/nixos-hardware/master";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.polymc.url = "github:PolyMC/PolyMC";

  outputs = { self, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, polymc, ... }: {
    nixosConfigurations."xps" =
      let
        system = "x86_64-linux";
      in
      nixpkgs.lib.nixosSystem {
        inherit system;
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
              (import ./pkgs)
              polymc.overlay
              (final: prev: {
                stable = import nixpkgs-stable {
                  inherit system;
                  config.allowUnfree = true;
                };
              })
            ];
            nixpkgs.config.allowUnfree = true;
            nix.registry.nixpkgs.flake = nixpkgs;
          }
        ];
      };
  };
}
