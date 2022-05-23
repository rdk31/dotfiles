{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
    keybindings = builtins.fromJSON (builtins.readFile ./keybindings.json);
    extensions = (with pkgs.vscode-extensions; [
      ms-python.python
      ms-python.vscode-pylance
      jnoortheen.nix-ide
      ms-azuretools.vscode-docker
      #vadimcn.vscode-lldb 
      matklad.rust-analyzer
      serayuzgur.crates
      vscodevim.vim
      eamodio.gitlens
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
      ms-toolsai.jupyter-renderers
      #ms-vscode.cpptools
    ]);
  };

  home.packages = with pkgs; [
    nixpkgs-fmt
  ];
}
