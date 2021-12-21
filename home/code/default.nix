{ config, pkgs, ... }:
let
  jupyter-renderers = pkgs.vscode-utils.extensionFromVscodeMarketplace {
      name = "jupyter-renderers";
      publisher = "ms-toolsai";
      version = "1.0.4";
      sha256 = "aKWu0Gp0f28DCv2akF/G8UDaGfTN410CcH8CAmW7mgU=";
  };
in {
  programs.vscode = {
    enable = true;
    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
    extensions = (with pkgs.vscode-extensions; [
      ms-python.python
      ms-python.vscode-pylance
      #bbenoist.Nix 
      #jnoortheen.nix-ide arrterian.nix-env-selector
      #ms-azuretools.vscode-docker
      #vadimcn.vscode-lldb 
      matklad.rust-analyzer
      serayuzgur.crates
      vscodevim.vim
      eamodio.gitlens
      coenraads.bracket-pair-colorizer-2
      esbenp.prettier-vscode
      #formulahendry.auto-rename-tag
      #formulahendry.auto-close-tag
      mskelton.one-dark-theme
      pkief.material-icon-theme
      formulahendry.code-runner
      #rubbersheep.gi
      usernamehw.errorlens
      # csharp
      # mshr-h.veriloghdl
      # platformio.platformio-ide
      tamasfe.even-better-toml
      ms-toolsai.jupyter
      jupyter-renderers
    ]);
  };

  #home.packages = with pkgs; [
  #  nixpkgs-fmt
  #];
}
