local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lsp-format").setup {}
vim.cmd [[cabbrev wq execute "Format sync" <bar> wq]]

local on_attach = function(client, bufnr)
  require("lsp-format").on_attach(client)

  local opts = {
      noremap = true,
      silent = true
  }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

end

require('lspconfig').pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
require('lspconfig').tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
require('lspconfig').clangd.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
require('lspconfig').rnix.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
require("lspconfig").diagnosticls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
  init_options = {
    formatters = {
      black = {
        command = "black",
        args = {"--quiet", "-"},
      },
      isort = {
        command = "isort",
        args = { "--quiet", "-" },
      },
    },
    formatFiletypes = {
      python = { "isort", "black" },
    }
  }
}

require('rust-tools').setup{
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          command = "clippy",
        },
      }
    }
  }
}