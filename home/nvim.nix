{ packages, ... }:
{
  # programs.neovim = {
  #   enable = true;

  #   viAlias = true;
  #   vimAlias = true;

  #   defaultEditor = true;

  #   package = pkgs.neovim;
  # };


  home.packages = [
    packages.nvim
  ];

  home.sessionVariables.EDITOR = "nvim";
}
