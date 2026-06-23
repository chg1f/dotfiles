---@class LazyVimPlugin

local M = {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "tokyonight",
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
		-- enabled = false,
		opts = {
			install_root = vim.fn.stdpath("data") .. "/mason",
		},
	},
	{
		"folke/snacks.nvim",
		opts = {
			dashboard = { enabled = false },
			picker = {
				sources = {
					explorer = {
						win = {
							input = {
								keys = {
									["<C-f>"] = { "list_scroll_down", mode = { "i", "n" } },
									["<C-b>"] = { "list_scroll_up", mode = { "i", "n" } },

									-- -- keep preview scrolling on Alt keys
									-- ["<A-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
									-- ["<A-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
									-- ["<A-l>"] = { "preview_scroll_right", mode = { "i", "n" } },
									-- ["<A-h>"] = { "preview_scroll_left", mode = { "i", "n" } },
								},
							},
							list = {
								keys = {
									["<C-f>"] = "list_scroll_down",
									["<C-b>"] = "list_scroll_up",

									-- ["<A-f>"] = "preview_scroll_down",
									-- ["<A-b>"] = "preview_scroll_up",
									-- ["<A-l>"] = "preview_scroll_right",
									-- ["<A-h>"] = "preview_scroll_left",
								},
							},
						},
					},
				},
			},
		},
	},
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
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				indicator = { style = "underline" },
				left_trunc_marker = ">>",
				right_trunc_marker = "<<",
				always_show_bufferline = true,
				show_buffer_icons = false,
				show_buffer_close_icons = false,
				sort_by = "insert_after_current",
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
							-- experimentalDisabledAnalyses = { "ST1000", "ST1003" },
							directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
							semanticTokens = true,
							gofumpt = true,
							analyses = {
								fieldalignment = false,
								nilness = true,
								unusedparams = true,
								unusedwrite = true,
								useany = true,

								ST1000 = false,
								ST1003 = false,
								QF1008 = false,
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
	{
		"mfussenegger/nvim-lint",
		opts = {
			linter_by_ft = {
				zsh = { "zsh" },
				-- go = { "golangcilint" },
				typescript = { "biomejs" },
				javascript = { "biomejs" },
				json = { "biomejs" },
				sql = { "sqlfluff" },
			},
			linters = {
				-- golangcilint = {
				-- 	executable = "golangci-lint",
				-- 	args = { "run", "--out-format=json" },
				-- },
				sqlfluff = {
					args = function()
						return {
							"lint",
							"--format=json",
							"--dialect",
							"mysql",
							"--exclude-rules",
							"AM04",
							"-",
						}
					end,
				},
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			-- default_format_opts = 5000, -- 5s
			-- log_level = vim.log.levels.DEBUG,
			formatters_by_ft = {
				lua = { "stylua" },
				zsh = { "shfmt" },
				sh = { "shfmt" },
				sql = { "sqlfluff" },
			},
			formatters = {
				sqlfluff = {
					args = function(_, _)
						return {
							"fix",
							"--dialect",
							"mysql",
							"--exclude-rules",
							"AM04",
							"--stdin-filename",
							"$FILENAME",
							"-",
						}
					end,
					require_cwd = false,
				},
			},
		},
	},
}

return M
