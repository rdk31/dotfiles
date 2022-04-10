{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      onedark-vim

      nvim-web-devicons
      nvim-tree-lua

      nvim-lspconfig
      nvim-compe

      telescope-nvim
      popup-nvim
      plenary-nvim
      nvim-treesitter
      bufferline-nvim

      nvim-autopairs
      indent-blankline-nvim

      lualine-nvim

      vim-nix
      rust-tools-nvim
    ];
    extraConfig = ''
      colorscheme onedark
      lua << EOF
      ${builtins.readFile ./nvim.lua}
      ${builtins.readFile ./treesitter.lua}
      ${builtins.readFile ./lsp.lua}
      ${builtins.readFile ./indent-blankline.lua}
      ${builtins.readFile ./bufferline.lua}
      EOF
    '';
    extraPackages = with pkgs; [
      gcc
      pyright
      nodePackages.diagnostic-languageserver
      nodePackages.typescript-language-server
      rust-analyzer rustfmt
      rnix-lsp
      clang_9
    ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
