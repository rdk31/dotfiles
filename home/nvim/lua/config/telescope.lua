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
      "node_modules",
      "target"
    } 
	},
})

telescope.load_extension("file_browser")

wk.register({
  f = { builtin.find_files, "Find file" },
  g = { builtin.live_grep, "Live grep" },
  t = { builtin.treesitter, "Treesitter" },
  rf = { builtin.lsp_references, "References" },
  e = { telescope.extensions.file_browser.file_browser, "File browser" },
}, { prefix = "<leader>" })
