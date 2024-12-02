---@class LazyVimPlugin
return {
	{
		"LazyVim/LazyVim",
		-- keys = {
		--   { "<leader>L", function() end },
		-- },
		opts = {
			colorscheme = "tokyonight-night",
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
	-- ui
	{ "nvimdev/dashboard-nvim", enabled = false },
	{
		"nvim-lualine/lualine.nvim",
		opts = function()
			return {
				options = {
					-- icons_enabled = false,
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
							"diagnostics",
							symbols = {
								error = LazyVim.config.icons.diagnostics.Error,
								warn = LazyVim.config.icons.diagnostics.Warn,
								info = LazyVim.config.icons.diagnostics.Info,
								hint = LazyVim.config.icons.diagnostics.Hint,
							},
						},
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return LazyVim.ui.fg("Debug") end,
            },
					},
					lualine_c = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end, -- # spellchecker:disable-line
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end, -- # spellchecker:disable-line
              color = function() return LazyVim.ui.fg("Constant") end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return LazyVim.ui.fg("Special") end,
            },
						"progress",
						"location",
						"searchcount",
						"selectioncount",
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end, -- # spellchecker:disable-line
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end, -- # spellchecker:disable-line
              color = function() return LazyVim.ui.fg("Statement") end,
            },
					},
					lualine_x = {
						"filesize",
						"encoding",
						{
							"fileformat",
							symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
						},
						-- "branch",
						LazyVim.lualine.pretty_path(),
					},
					lualine_y = {
						LazyVim.lualine.root_dir(),
					},
					lualine_z = {
						"filetype",
					},
				},
			}
		end,
	},
	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				indicator = { style = "underline" },
				always_show_bufferline = true,
				show_buffer_close_icons = false,
			},
		},
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
		"rcarriga/nvim-notify",
		opts = {
			icons = {
				DEBUG = " ",
				ERROR = " ",
				WARN = " ",
				INFO = " ",
				TRACE = " ",
			},
		},
	},
	{
		"folke/noice.nvim",
		opts = {
			views = {
				-- cmdline_popup = {
				--   position = { row = "50%", col = "50%" },
				-- },
				-- cmdline_popupmenu = {
				--   relative = "editor",
				--   position = "auto",
				-- },
			},
		},
	},
	{
		"echasnovski/mini.animate",
		enable = false,
		opts = function()
			return {
				resize = {
					enable = false,
					-- timing = require("animate").gen_timing.linear({ duration = 50, unit = "total" }),
				},
			}
		end,
	},
	-- {
	--   "indent-blankline.nvim",
	--   enabled = false,
	-- },
	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			highlight = {
				disable = function(_, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
		},
	},
	-- coding
	{
		"mason.nvim",
		opts = {
			install_root = vim.fn.stdpath("data") .. "/mason",
		},
	},
	{ "windwp/nvim-ts-autotag", ft = "typescript" },
	{ "folke/ts-comments.nvim", ft = "typescript" },
	-- editor
	{
		"folke/which-key.nvim",
		keys = {
			-- {
			--   "<leader>?",
			--   function()
			--     require("which-key").show({ global = false })
			--   end,
			--   desc = "Buffer Keymaps (which-key)",
			-- },
		},
	},
	{
		"folke/todo-comments.nvim",
		opts = {
			keywords = {
				BUG = { icon = " ", color = "error", alt = { "ISSUE", "FIX", "FIXME", "FIXIT" } },
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = "󰾆 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = "󱞂 ", color = "hint", alt = { "INFO", "REFERENCE", "REF" } },
				TEST = { icon = "󰐍 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			window = {
				mappings = {
					-- ["P"] = function(state)
					--   local node = state.tree:get_node()
					--   require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
					-- end,
				},
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{
				"<leader>?",
				function()
					require("telescope.builtin").builtin()
				end,
				desc = "Telescope",
			},
			{
				"<leader><space>",
				function()
					require("telescope.builtin").resume()
				end,
				desc = "Resume",
			},
		},
		opts = {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
			},
			pickers = {
				builtin = {
					include_extensions = true,
					use_default_opts = true,
				},
				find_files = {
					hidden = true,
					no_ignore = true,
					-- no_ignore_parent = true,
				},
				colorscheme = {
					enable_preview = true,
				},
				lsp_definitions = {
					jump_type = "vsplit",
				},
				lsp_references = {
					jump_type = "vsplit",
				},
				lsp_implementations = {
					jump_type = "vsplit",
				},
				lsp_type_definitions = {
					jump_type = "vsplit",
				},
			},
		},
	},
	-- linting
	{
		"mfussenegger/nvim-lint",
		-- opts = {
		-- 	linters_by_ft = {
		-- 		go = { "golangcilint" },
		-- 	},
		-- },
	},
	-- lsp
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
			-- setup = {
			--   gopls = function(_, opts)
			--     --ISSUE: https://github.com/neovim/neovim/issues/28058
			--     if type(opts) == "table" and opts.workspace then
			--       opts.workspace.didChangeWatchedFiles = {
			--         dynamicRegistration = false,
			--         relativePatternSupport = false,
			--       }
			--     end
			--   end,
			-- },
		},
	},
	-- TODO: extend
	-- {
	--   "fatih/vim-go",
	--   config = function()
	--     -- we disable most of these features because treesitter and nvim-lsp
	--     -- take care of it
	--     vim.g["go_gopls_enabled"] = 0
	--     vim.g["go_code_completion_enabled"] = 0
	--     vim.g["go_fmt_autosave"] = 0
	--     vim.g["go_imports_autosave"] = 0
	--     vim.g["go_mod_fmt_autosave"] = 0
	--     vim.g["go_doc_keywordprg_enabled"] = 0
	--     vim.g["go_def_mapping_enabled"] = 0
	--     vim.g["go_textobj_enabled"] = 0
	--     vim.g["go_list_type"] = "quickfix"
	--   end,
	-- },
}
