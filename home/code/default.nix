{ config, pkgs, lib, ... }:
let
  marketplaceExtensions = [
    (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
      mktplcRef = {
        name = "copilot";
        publisher = "GitHub";
        version = "1.31.6194";
        sha256 = "sha256-obUu3pHvdwzWBejVWl94Ki8YN7ujHukNX0gvRdWhBYw=";
      };

      meta = {
        license = lib.licenses.unfree;
      };
    })
  ];
in
{
  programs.vscode = {
    enable = true;
    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
    keybindings = builtins.fromJSON (builtins.readFile ./keybindings.json);
    extensions = (with pkgs.vscode-extensions; [
      ms-python.python
      ms-python.vscode-pylance
      jnoortheen.nix-ide
      #vadimcn.vscode-lldb 
      matklad.rust-analyzer
      vscodevim.vim
      eamodio.gitlens
      esbenp.prettier-vscode
      #formulahendry.auto-rename-tag
      #formulahendry.auto-close-tag
      mskelton.one-dark-theme
      pkief.material-icon-theme
      #rubbersheep.gi
      usernamehw.errorlens
      # csharp
      # mshr-h.veriloghdl
      # platformio.platformio-ide
      ms-toolsai.jupyter
      ms-toolsai.jupyter-renderers
      ms-vscode.cpptools
      ms-vscode-remote.remote-ssh
      james-yu.latex-workshop
      foam.foam-vscode
      yzhang.markdown-all-in-one
      #github.copilot
    ]) ++ marketplaceExtensions;
  };

  home.packages = with pkgs; [
    nixpkgs-fmt
  ];
}
