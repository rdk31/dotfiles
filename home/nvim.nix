{ inputs, lib, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    colorschemes.onedark.enable = true;

    opts = {
      mouse = "a";
      termguicolors = true;
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      autoindent = true;
      smartindent = true;
      signcolumn = "yes";
      cursorline = true;
      incsearch = true;
    };

    globals.mapleader = " ";
    keymaps = [
      { mode = "n"; key = "<C-k>"; options.silent = true; action = ":BufferNext<CR>"; }
      { mode = "n"; key = "<C-j>"; options.silent = true; action = ":BufferPrevious<CR>"; }
      { mode = "n"; key = "<C-q>"; options.silent = true; action = ":BufferClose<CR>"; }
      { mode = "n"; key = "<A-0>"; options.silent = true; action = ":BufferLast<CR>"; }
      { mode = "n"; key = "<leader>e"; options.silent = true; action = ":Telescope file_browser<CR>"; }
    ] ++ (map
      (i: { mode = "n"; key = "<A-${toString i}>"; options.silent = true; action = ":BufferGoto ${toString i}<CR>"; })
      (lib.lists.range 1 9)
    );

    plugins = {
      telescope = {
        enable = true;
        extensions = {
          file-browser.enable = true;
          fzf-native.enable = true;
          frecency.enable = true;
        };
        keymaps = {
          "<leader>f" = "find_files";
          "<leader>g" = "live_grep";
        };
      };
      treesitter.enable = true;
      barbar.enable = true;
      lualine.enable = true;
      nvim-autopairs.enable = true;
      gitsigns.enable = true;
      lsp = {
        enable = true;
        servers = {
          pyright.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          nil_ls.enable = true;
        };
      };
      rust-tools.enable = true;
      conform-nvim = {
        enable = true;
        formatOnSave = { };
        formattersByFt = {
          nix = [ "alejandra" "nixfmt" "nixpkgs_fmt" ];
          python = [ "isort" "black" ];
        };
      };
      cmp = {
        enable = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "nvim_lsp_signature_help"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
        };
      };
    };
  };

  home.sessionVariables.EDITOR = "nvim";
}
