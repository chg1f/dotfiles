---@class LazyVimPlugin
return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "gruvbox",
			-- colorscheme = "cyberdream",
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
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUpdate",
		},
		opts = {
			install_root = vim.fn.stdpath("data") .. "/mason",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		cmd = {
			"MasonToolsInstallSync",
			"MasonToolsUpdateSync",
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
						"filetype",
						{
							"diagnostics",
							symbols = {
								error = "E",
								warn = "W",
								info = "I",
								hint = "H",
							},
						},
					},
					lualine_c = {
						"progress",
						"location",
						"searchcount",
						"selectioncount",
					},
					lualine_x = {
						{
							"diff",
							symbols = {
								added = "+",
								removed = "-",
								modified = "~",
							},
						},
						"branch",
					},
					lualine_y = {
						"filesize",
						LazyVim.lualine.pretty_path({
							modified_sign = "*",
							readonly_icon = "!",
						}),
					},
					lualine_z = {
						"encoding",
						{
							"fileformat",
							icons_enabled = true,
							symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
						},
					},
				},
			}
		end,
	},
	-- {
	-- 	"lewis6991/gitsigns.nvim",
	-- 	opts = {
	-- 		signs = {
	-- 			add = { text = "+" },
	-- 			change = { text = "~" },
	-- 			changedelete = { text = "~" },
	-- 			delete = { text = "_" },
	-- 			topdelete = { text = "‾" },
	-- 			untracked = { text = ":" },
	-- 		},
	-- 		signs_staged = {
	-- 			add = { text = "+" },
	-- 			change = { text = "~" },
	-- 			delete = { text = "_" },
	-- 			topdelete = { text = "‾" },
	-- 			changedelete = { text = "~" },
	-- 		},
	-- 	},
	-- },
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
	-- 		linter_by_ft = {
	-- 			go = { "golangcilint" },
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
}
