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
        ms-python.mypy-type-checker
        redhat.vscode-yaml
        jnoortheen.nix-ide
        vscodevim.vim
        mskelton.one-dark-theme
        pkief.material-icon-theme
        ms-toolsai.jupyter
        ms-toolsai.jupyter-renderers
        ms-vscode-remote.remote-ssh
        charliermarsh.ruff
        github.copilot
      ]
    );
  };

  home.packages = with pkgs; [ nixfmt-rfc-style ];
}
