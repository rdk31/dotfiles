{ config, pkgs, lib, ... }:
let
  marketplaceExtensions = [
    #(pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    #  mktplcRef = {
    #    name = "copilot";
    #    publisher = "GitHub";
    #    version = "1.44.6735";
    #    sha256 = "sha256-8Z16yfG4I6TpzzKUm6xLSEr6NT//pEjfW5+biC4G+4M=";
    #  };

    #  meta = {
    #    license = lib.licenses.unfree;
    #  };
    #})
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
      matangover.mypy
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
