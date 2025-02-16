{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;
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
        ms-toolsai.jupyter-keymap
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.vscode-jupyter-slideshow
        ms-vscode-remote.remote-ssh
        charliermarsh.ruff
        github.copilot
        rust-lang.rust-analyzer
        platformio.platformio-ide
        mechatroner.rainbow-csv
        aaron-bond.better-comments
        ms-toolsai.datawrangler
        tamasfe.even-better-toml
        pkgs.vscode-extensions.ms-vscode.cpptools
      ]
    );
  };

  home.packages = with pkgs; [ nixfmt-rfc-style ];
}
