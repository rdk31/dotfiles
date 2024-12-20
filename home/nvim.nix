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
  ];

  home.sessionVariables.EDITOR = "nvim";
}
