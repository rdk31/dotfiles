{ config, pkgs, ... }:
{
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
    ]);
  };

  #home.packages = with pkgs; [
  #  nixpkgs-fmt
  #];
}
