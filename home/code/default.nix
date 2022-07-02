{ config, pkgs, lib, ... }:
let
  marketplaceExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    # {
    #   name = "spellright";
    #   publisher = "ban";
    #   version = "3.0.64";
    #   sha256 = "sha256-OCbMTTrXCF/JkzD9b1nz/MwpxGseMTiFOloS8CHsCu0=";
    # }
  ] ++ [
    (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
      mktplcRef = {
        name = "vscode-pylance";
        publisher = "MS-python";
        version = "2022.6.30";
        sha256 = "sha256-qRhVZSZGXzPer6zGYVhUPF3iVAuouXv7OFLpKT5fF5E=";
      };

      buildInputs = [ pkgs.nodePackages.pyright ];

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
      # ms-python.vscode-pylance
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
      svelte.svelte-vscode
      github.copilot
    ]) ++ marketplaceExtensions;
  };

  home.packages = with pkgs; [
    nixpkgs-fmt
  ];
}
