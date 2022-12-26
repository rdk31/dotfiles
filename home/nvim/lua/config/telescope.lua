local telescope = require("telescope")
local builtin = require("telescope.builtin")
local wk = require("which-key")

telescope.setup({
	defaults = {
		layout_config = {
			horizontal = {
				width = 0.9,
			},
		},
    file_ignore_patterns = {
      "node_modules/",
      "target/",
      ".git/",
      ".direnv/"
    } 
	},
})

telescope.load_extension("file_browser")

wk.register({
  f = { function() builtin.find_files({ hidden=true }) end, "Find file" },
  F = { function() builtin.find_files({ hidden=true, no_ignore=true }) end, "Find file (with files ignored by .gitignore)" },
  g = { builtin.live_grep, "Live grep" },
  t = { builtin.treesitter, "Treesitter" },
  rf = { builtin.lsp_references, "References" },
  e = { telescope.extensions.file_browser.file_browser, "File browser" },
}, { prefix = "<leader>" })
