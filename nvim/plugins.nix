{
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
        nil-ls.enable = true;
      };
    };
    rust-tools.enable = true;
    conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          lspFallback = true;
          timeoutMs = 500;
        };
        notify_on_error = true;
        formattersByFt = {
          nix = [ "nixfmt" ];
          python = [
            "isort"
            "black"
          ];
        };
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
}
