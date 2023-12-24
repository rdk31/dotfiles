{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      onedark-nvim

      nvim-web-devicons
      nvim-tree-lua

      nvim-lspconfig

      nvim-cmp
      cmp-nvim-lsp
      cmp-path
      cmp-buffer
      cmp_luasnip
      luasnip
      friendly-snippets
      lspkind-nvim
      nvim-lightbulb
      cmp-nvim-lsp-signature-help

      telescope-nvim
      telescope-file-browser-nvim
      popup-nvim
      plenary-nvim
      nvim-treesitter.withAllGrammars
      rainbow-delimiters-nvim
      bufferline-nvim

      nvim-autopairs
      indent-blankline-nvim

      lualine-nvim

      vim-slash
      gitsigns-nvim

      vim-nix
      rust-tools-nvim

      lsp-format-nvim

      which-key-nvim
    ];
    extraConfig = ''
      lua << EOF
        require("config.general")
        require("config.bufferline")
        require("config.blankline")
        require("config.lsp")
        require("config.lsp_cmp")
        require("config.treesitter")
        require("config.telescope")
        require("config.tree")
      EOF
    '';
    extraPackages = with pkgs; [
      # c/c++
      gcc
      clang_9

      # python
      pyright
      nodePackages.diagnostic-languageserver
      black
      isort

      # javascript/typescript
      nodePackages.typescript-language-server
      nodePackages.typescript
      nodePackages.prettier

      # rust
      rust-analyzer
      rustfmt

      # nix
      rnix-lsp

      # telescope
      ripgrep
      fd

      # terraform
      terraform-ls
    ];
  };

  # TODO: hardcoded path
  xdg.configFile."nvim/lua".source =
    config.lib.file.mkOutOfStoreSymlink /home/rdk/.dotfiles/home/nvim/lua;

  home.sessionVariables = { EDITOR = "nvim"; };
}
