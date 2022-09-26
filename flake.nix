{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.05";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";
    polymc.url = "github:PolyMC/PolyMC";

    agenix.url = "github:ryantm/agenix";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, agenix, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, polymc, ... }@inputs: {
    nixosConfigurations."xps" =
      let
        system = "x86_64-linux";
      in
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
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
          agenix.nixosModule
        ];
      };
    hydraJobs = builtins.mapAttrs (_: system: system.config.system.build.toplevel) self.nixosConfigurations;
  } //
  (flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.default = pkgs.mkShell {
        packages = [
          agenix.defaultPackage.${system}
        ];
      };
    }
  ));
}
