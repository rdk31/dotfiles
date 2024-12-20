{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = (
      with (pkgs.nix-vscode-extensions.forVSCodeVersion pkgs.vscode.version).vscode-marketplace;
      [
        ms-python.python
        ms-python.vscode-pylance
        ms-python.black-formatter
        redhat.vscode-yaml
        jnoortheen.nix-ide
        vscodevim.vim
        mskelton.one-dark-theme
        pkief.material-icon-theme
        ms-toolsai.jupyter
        ms-toolsai.jupyter-renderers
        ms-vscode-remote.remote-ssh
        github.copilot
      ]
    );
  };

  home.packages = with pkgs; [ nixfmt-rfc-style ];
}
