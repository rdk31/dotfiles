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

    (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
      mktplcRef = {
        name = "isort";
        publisher = "ms-python";
        version = "2023.9.11721010";
        sha256 = "sha256-s+TEhmB27mZVMnem2DDV62656Q31umLMRP6fxeHSvY0=";
      };
      meta = {
        license = lib.licenses.mit;
      };
    })

    (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
      mktplcRef = {
        name = "gitlens";
        publisher = "eamodio";
        version = "2022.12.604";
        sha256 = "sha256-yfqGITviASp5ZDEJA+zyVz1LpPWV4FM/4fU4eq52Xng=";
      };
      meta = {
        license = lib.licenses.mit;
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
      #eamodio.gitlens
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
      golang.go
      #yzhang.markdown-all-in-one
      github.copilot
    ]) ++ marketplaceExtensions;
  };

  home.packages = with pkgs; [
    nixpkgs-fmt
  ];
}
