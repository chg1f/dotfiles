---@class LazyVimPlugin
local M = {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "cyberdream",
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
		-- cmd = {
		-- 	"MasonUpdate",
		-- 	"MasonUpgrade",
		-- },
		-- init = function()
		-- 	vim.api.nvim_create_user_command("MasonUpgrade", function()
		-- 		local platform = require("mason-core.platform")
		--
		-- 		local upgrade = function()
		-- 			local registry = require("mason-registry")
		-- 			local packages = registry.get_installed_packages()
		--
		-- 			local notify = require("mason-core.notify")
		-- 			notify("Upgrading packages...")
		--
		-- 			for _, pkg in ipairs(packages) do
		-- 				pkg:check_new_version(function(ok, version)
		-- 					if ok then
		-- 						if version.latest_version ~= version.current_version then
		-- 							pkg:install({ version = version.latest_version }):once("completed", function()
		-- 								notify("Upgraded " .. pkg.name .. " to version " .. version.latest_version)
		-- 							end)
		-- 						else
		-- 							notify(pkg.name .. " is already up to date")
		-- 						end
		-- 					else
		-- 						notify("Failed to check for new version of " .. pkg.name, vim.log.levels.ERROR)
		-- 					end
		-- 				end)
		-- 			end
		-- 		end
		--
		-- 		if platform.is_headless then
		-- 			local a = require("mason-core.async")
		-- 			a.run_blocking(function()
		-- 				upgrade()
		-- 			end)
		-- 		else
		-- 			upgrade()
		-- 		end
		-- 	end, { force = true })
		-- end,
	},
	{
		"folke/snacks.nvim",
		opts = {
			dashboard = { enabled = false },
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
					args = {
						"lint",
						"--format=json",
						"--dialect=mysql",
						"--disable-progress-bar",
					},
				},
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				sql = { "sqlfluff" },
			},
			formatters = {
				sqlfluff = {
					args = {
						"fix",
						"--dialect=mysql",
						"--disable-progress-bar",
					},
				},
			},
		},
	},
}

return M
