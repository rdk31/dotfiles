{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ragenix.url = "github:yaxitech/ragenix";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    {
      self,
      flake-parts,
      ragenix,
      nix-vscode-extensions,
      nix-matlab,
      nixvim,
      nixpkgs,
      nixpkgs-stable,
      nixos-hardware,
      home-manager,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { withSystem, ... }:
      {
        flake =
          let
            xps =
              ciBuild:
              withSystem "x86_64-linux" (
                { config, system, ... }:
                nixpkgs.lib.nixosSystem {
                  inherit system;
                  specialArgs = {
                    inherit inputs;
                  };
                  modules = [
                    nixos-hardware.nixosModules.dell-xps-13-9310
                    ./configuration.nix
                    home-manager.nixosModules.home-manager
                    {
                      home-manager.useGlobalPkgs = true;
                      home-manager.useUserPackages = true;
                      home-manager.users.rdk = import ./home;
                      home-manager.extraSpecialArgs = {
                        packages = config.packages;
                        inherit inputs ciBuild;
                      };
                    }
                    {
                      nixpkgs.overlays = [
                        (import ./pkgs)
                        (final: prev: {
                          nixpkgs-stable = import nixpkgs-stable {
                            inherit system;
                            config.allowUnfree = true;
                          };
                          nix-vscode-extensions = nix-vscode-extensions.extensions.${system};
                        })
                      ];
                      nixpkgs.config.allowUnfree = true;
                      nix.registry.nixpkgs.flake = nixpkgs;
                    }
                    ragenix.nixosModules.default
                  ];
                }
              );
          in
          {
            nixosConfigurations = {
              "xps" = xps false;
              "xps-ci" = xps true;
            };
          };

        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ];

        perSystem =
          { pkgs, system, ... }:
          let
            nixvimLib = nixvim.lib.${system};
            nixvim' = nixvim.legacyPackages.${system};
            nixvimModule = {
              inherit pkgs;
              module = import ./nvim;
            };
            nvim = nixvim'.makeNixvimWithModule nixvimModule;
          in
          {
            checks = {
              default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
            };

            packages = {
              default = nvim;
              nvim = nvim;
            };
          };
      }
    );
}
