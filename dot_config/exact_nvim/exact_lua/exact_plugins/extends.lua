---@class LazyVimPlugin
local plugins = {}

plugins = vim.list_extend(plugins, {
	{
		"fatih/vim-go",
		ft = "go",
		config = function()
			-- we disable most of these features because treesitter and nvim-lsp
			-- take care of it
			vim.g.go_gopls_enabled = 0
			vim.g.go_code_completion_enabled = 0
			vim.g.go_fmt_autosave = 0
			vim.g.go_imports_autosave = 0
			vim.g.go_mod_fmt_autosave = 0
			vim.g.go_doc_keywordprg_enabled = 0
			vim.g.go_def_mapping_enabled = 0
			vim.g.go_textobj_enabled = 0
			vim.g.go_list_type = "quickfix"
		end,
	},
	{
		"rgroli/other.nvim",
		ft = { "go" },
		cmd = { "Other", "OtherTabNew", "OtherSplit", "OtherVSplit" },
		keys = {
			{ "<leader>o", "<cmd>OtherVSplit<cr>", desc = "Open alternative files" },
		},
		main = "other-nvim",
		opts = {
			mappings = {
				{
					pattern = "(.*).go$",
					target = "%1_test.go",
					context = "test",
				},
				{
					pattern = "(.*)_test.go$",
					target = "%1.go",
					context = "file",
				},
				-- {
				-- 	pattern = "(.*)/(.*).go$",
				-- 	target = "%1/types.go",
				-- 	context = "",
				-- },
			},
		},
	},
	-- {
	--   "LunarVim/bigfile.nvim",
	--   lazy = false,
	--   opts = {
	--     filesize = 2, -- in MiB
	--     pattern = { "*" },
	--     features = { -- features to disable
	--       "indent_blankline",
	--       "illuminate",
	--       "lsp",
	--       "treesitter",
	--       "syntax",
	--       "matchparen",
	--       "vimopts",
	--       "filetype",
	--     },
	--   },
	-- },
})

return plugins
