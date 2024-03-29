{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";

    agenix.url = "github:ryantm/agenix";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , flake-utils
    , agenix
    , nixpkgs
    , nixpkgs-stable
    , nixos-hardware
    , home-manager
    , ...
    }@inputs:
    let
      xps = ciBuild:
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
              home-manager.extraSpecialArgs = { inherit inputs ciBuild; };
            }
            {
              nixpkgs.overlays = [
                (import ./pkgs)
                (final: prev: {
                  nixpkgs-stable = import nixpkgs-stable {
                    inherit system;
                    config.allowUnfree = true;
                  };
                })
              ];
              nixpkgs.config.allowUnfree = true;
              nix.registry.nixpkgs.flake = nixpkgs;
            }
            agenix.nixosModules.default
          ];
        };
    in
    {
      nixosConfigurations = {
        "xps" = xps false;
        "xps-ci" = xps true;
      };
    };
}
