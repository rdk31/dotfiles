require('indent_blankline').setup{
  use_treesitter = true,
  show_first_indent_level = false,

 -- show_current_context = true,
	--context_patterns = {
	--	"class",
	--	"function",
	--	"method",
	--	"for_statement",
	--	"try_statement",
	--	"except_clause",
	--	"finally_clause",
	--	"while_statement",
	--	"if_statement",
	--	"with_statement",
	--},
	filetype_exclude = { "NvimTree" },
}
