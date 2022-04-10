require('lspconfig').pyright.setup{}
require('lspconfig').tsserver.setup{}
require('lspconfig').rust_analyzer.setup{}
require('lspconfig').clangd.setup{}
require('lspconfig').rnix.setup{}
require("lspconfig").diagnosticls.setup {
  filetypes = {"python"},
  init_options = {
    formatters = {
      black = {
        command = "black",
        args = {"--quiet", "-"},
      },
    },
    formatFiletypes = {
      python = {"black"}
    }
  }
}

require('rust-tools').setup{}

vim.o.completeopt = "menuone,noselect"

-- Autocompletion setup
require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = false;
    source = {
        path = true;
        buffer = true;
        nvim_lsp = true;
        treesitter = true;
    };
}

-- Set tab to accept the autocompletion
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    else
        return t "<S-Tab>"
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
