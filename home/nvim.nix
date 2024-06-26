{ pkgs, packages, ... }:
{
  # programs.neovim = {
  #   enable = true;

  #   viAlias = true;
  #   vimAlias = true;

  #   defaultEditor = true;

  #   package = pkgs.neovim;
  # };

  home.packages = with pkgs; [
    packages.nvim

    nixfmt-rfc-style
    nil

    pyright
    black
    isort
  ];

  home.sessionVariables.EDITOR = "nvim";
}
