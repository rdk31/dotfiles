local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

g.mapleader = ' '

opt.smartindent = true
opt.autoindent = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.mouse = "a"

opt.termguicolors = true
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"

opt.clipboard = "unnamedplus"

opt.hidden = true
opt.incsearch = true

local map = vim.api.nvim_set_keymap
options = { noremap = true, silent = true }
map('n', '<leader>h', ':bprevious<CR>', options)
map('n', '<leader>l', ':bnext<CR>', options)
map('n', '<leader>d', ':bdelete<CR>', options)

map('n', '<leader>w', ':w<CR>', options)

map('n', '<leader>f', ':Telescope find_files<CR>', options)
map('n', '<leader>g', ':Telescope live_grep<CR>', options)
map('n', '<leader>b', ':Telescope buffers<CR>', options)

map('n', '<leader>n', ':NvimTreeToggle<CR>', options)

map('n', '<leader>F', ':lua vim.lsp.buf.formatting()<CR>', options)

require('nvim-autopairs').setup{}
require('nvim-tree').setup{}

require('lualine').setup {
  options = { theme = 'onedark' }
}

require('telescope').setup {
  defaults = { 
    file_ignore_patterns = {
      "node_modules",
      "target"
    } 
  } 
}
