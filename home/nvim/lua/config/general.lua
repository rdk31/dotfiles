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

--opt.clipboard = "unnamedplus"

opt.hidden = true
opt.incsearch = true

local map = vim.api.nvim_set_keymap
options = { noremap = true, silent = true }
map('n', '<leader>h', ':bprevious<CR>', options)
map('n', '<leader>l', ':bnext<CR>', options)
map('n', '<leader>q', ':bdelete<CR>', options)

require('lualine').setup({
  options = { theme = 'onedark' }
})

vim.api.nvim_set_option("timeoutlen", 300)
require("which-key").setup()

require('gitsigns').setup()
