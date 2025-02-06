---@class LazyVimPlugin
return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "gruvbox",
			news = {
				lazyvim = false,
				neovim = false,
			},
			icons = {
				diagnostics = {
					Error = "E",
					Warn = "W",
					Info = "I",
					Hint = "H",
				},
				git = {
					added = "+",
					modified = "~",
					removed = "-",
				},
			},
		},
	},
	{
		"mason.nvim",
		opts = {
			install_root = vim.fn.stdpath("data") .. "/mason",
		},
	},
	{
		"folke/snacks.nvim",
		opts = {
			dashboard = { enabled = false },
		},
	},
	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				indicator = { style = "underline" },
				left_trunc_marker = "»",
				right_trunc_marker = "«",
				always_show_bufferline = true,
				show_buffer_icons = false,
				show_buffer_close_icons = false,
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = function()
			return {
				options = {
					icons_enabled = false,
					component_separators = "",
					section_separators = "",
				},
				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function(s)
								return s:sub(1, 1):upper()
							end,
						},
					},
					lualine_b = {
						{
							"diagnostics",
							symbols = {
								error = LazyVim.config.icons.diagnostics.Error,
								warn = LazyVim.config.icons.diagnostics.Warn,
								info = LazyVim.config.icons.diagnostics.Info,
								hint = LazyVim.config.icons.diagnostics.Hint,
							},
						},
					},
					lualine_c = {
						{
							"fileformat",
							icons_enabled = true,
							symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
						},
						"encoding",
						"filesize",
						"progress",
						"location",
						"searchcount",
						"selectioncount",
					},
					lualine_x = {
						LazyVim.lualine.pretty_path({
							modified_sign = "*",
							readonly_icon = "!",
						}),
						LazyVim.lualine.root_dir(),
					},
					lualine_y = {
						{
							"diff",
							symbols = {
								added = LazyVim.config.icons.git.added,
								modified = LazyVim.config.icons.git.modified,
								removed = LazyVim.config.icons.git.removed,
							},
							source = function()
								if vim.b.gitsigns_status_dict then
									return {
										added = vim.b.gitsigns_status_dict.added,
										modified = vim.b.gitsigns_status_dict.changed,
										removed = vim.b.gitsigns_status_dict.removed,
									}
								end
							end,
						},
						{
							"branch",
						},
					},
					lualine_z = {
						{
							"filetype",
						},
					},
				},
			}
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				changedelete = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				untracked = { text = ":" },
			},
			signs_staged = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false },
			servers = {
				typos_lsp = {
					init_options = {
						diagnosticSeverity = "Hint",
					},
				},
				gopls = {
					settings = {
						gopls = {
							-- experimentalPostfixCompletions = true,
							usePlaceholders = true,
							completeUnimported = true,
							staticcheck = true,
							directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
							semanticTokens = true,
							gofumpt = true,
							analyses = {
								fieldalignment = false,
								nilness = true,
								unusedparams = true,
								unusedwrite = true,
								useany = true,
							},
							codelenses = {
								gc_details = false,
								generate = true,
								regenerate_cgo = true,
								run_govulncheck = true,
								test = true,
								tidy = true,
								upgrade_dependency = true,
								vendor = true,
							},
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},
			},
		},
	},
	-- {
	-- 	"mfussenegger/nvim-lint",
	-- 	opts = {
	-- 		linters = {
	-- 			sqlfluff = {
	-- 				args = { "lint", "--format=json", "--dialect=mysql" },
	-- 			},
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	"stevearc/conform.nvim",
	-- 	opts = function(_, opts)
	-- 		local sql_ft = { "sql", "mysql", "plsql" }
	-- 		opts.formatters.sqlfluff = {
	-- 			args = { "fix", "--dialect=mysql", "-" },
	-- 		}
	-- 		for _, ft in ipairs(sql_ft) do
	-- 			opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
	-- 			table.insert(opts.formatters_by_ft[ft], "sqlfluff")
	-- 		end
	-- 	end,
	-- },
	{
		"folke/which-key.nvim",
		opts = {
			preset = "helix",
			win = {
				col = 1, -- position of the floating window
			},
		},
	},
	{
		"monaqa/dial.nvim",
		keys = {
			-- {
			-- 	"<C-a>",
			-- 	function()
			-- 		return require("lazyvim.plugins.extras.editor.dial").dial(true)
			-- 	end,
			-- 	expr = true,
			-- 	desc = "Increment",
			-- 	mode = { "n", "v" },
			-- },
			-- {
			-- 	"g<C-a>",
			-- 	function()
			-- 		return require("lazyvim.plugins.extras.editor.dial").dial(true, true)
			-- 	end,
			-- 	expr = true,
			-- 	desc = "Increment",
			-- 	mode = { "n", "v" },
			-- },
		},
	},
	{
		"ibhagwan/fzf-lua",
		keys = {
			{
				"<leader><space>",
				function()
					require("fzf-lua").resume()
				end,
				desc = "Resume",
			},
			{
				"<leader>?",
				function()
					require("fzf-lua").builtin()
				end,
				desc = "Features",
			},
			{
				"<leader>h",
				function()
					require("fzf-lua").help_tags()
				end,
				desc = "Help",
			},
		},
	},
	-- {
	-- 	"nvim-telescope/telescope.nvim",
	-- 	keys = {
	-- 		{
	-- 			"<leader><space>",
	-- 			function()
	-- 				require("telescope.builtin").resume()
	-- 			end,
	-- 			desc = "Resume",
	-- 		},
	-- 		{
	-- 			"<leader>?",
	-- 			function()
	-- 				require("telescope.builtin").builtin()
	-- 			end,
	-- 			desc = "Features",
	-- 		},
	-- 		{
	-- 			"<leader>h",
	-- 			function()
	-- 				require("telescope.builtin").help_tags()
	-- 			end,
	-- 			desc = "Help",
	-- 		},
	-- 	},
	-- 	opts = {
	-- 		defaults = {
	-- 			prompt_prefix = " ",
	-- 			selection_caret = "> ",
	-- 		},
	-- 		pickers = {
	-- 			builtin = {
	-- 				include_extensions = true,
	-- 				use_default_opts = true,
	-- 			},
	-- 			find_files = {
	-- 				-- hidden = true,
	-- 				-- no_ignore = true,
	-- 				-- no_ignore_parent = true,
	-- 			},
	-- 			colorscheme = {
	-- 				-- enable_preview = true,
	-- 			},
	-- 			lsp_definitions = {
	-- 				jump_type = "vsplit",
	-- 			},
	-- 			lsp_references = {
	-- 				jump_type = "vsplit",
	-- 			},
	-- 			lsp_implementations = {
	-- 				jump_type = "vsplit",
	-- 			},
	-- 			lsp_type_definitions = {
	-- 				jump_type = "vsplit",
	-- 			},
	-- 		},
	-- 	},
	-- },
}
