{ config, pkgs, lib, ... }:
let
  marketplaceExtensions = [
    # (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    #   mktplcRef = {
    #     name = "platformio-ide";
    #     publisher = "platformio";
    #     version = "3.3.2";
    #     sha256 = "sha256-qYlhCioa3LiI67iubC1XQatY5JaeGLT26Q1Q1TWBczo=";
    #   };

    #   meta = {
    #     license = lib.licenses.asl20;
    #   };
    # })
  ];
in
{
  programs.vscode = {
    enable = true;
    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = (with pkgs.vscode-extensions; [
      ms-python.python
      ms-python.vscode-pylance
      ms-python.black-formatter
      #matangover.mypy
      jnoortheen.nix-ide
      matklad.rust-analyzer
      vscodevim.vim
      mskelton.one-dark-theme
      pkief.material-icon-theme
      ms-toolsai.jupyter
      ms-toolsai.jupyter-renderers
      ms-vscode.cpptools
      ms-vscode-remote.remote-ssh
      github.copilot
    ]) ++ marketplaceExtensions;
  };

  home.packages = with pkgs; [ nixpkgs-fmt mypy ];
}
