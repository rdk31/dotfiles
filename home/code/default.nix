{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = (
      with pkgs.nix-vscode-extensions.vscode-marketplace;
      [
        ms-python.python
        ms-python.vscode-pylance
        ms-python.black-formatter
        #matangover.mypy
        jnoortheen.nix-ide
        rust-lang.rust-analyzer
        vscodevim.vim
        mskelton.one-dark-theme
        pkief.material-icon-theme
        ms-toolsai.jupyter
        ms-toolsai.jupyter-renderers
        ms-vscode.cpptools
        ms-vscode-remote.remote-ssh
        #github.copilot
      ]
    );
  };

  home.packages = with pkgs; [ nixfmt-rfc-style ];
}
