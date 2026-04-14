---@class LazyVimPlugin

-- GoRoot finds the project root used by Go tooling configuration discovery.
-- It prefers the repository golangci config, then go module/workspace markers,
-- and finally the VCS root to keep lint/format behavior project-scoped.
local function GoRoot(filename)
	local match = vim.fs.find({ ".golangci.yml", ".golangci.yaml", "go.work", "go.mod", ".git" }, {
		path = filename,
		upward = true,
	})[1]
	return match and vim.fs.dirname(match) or nil
end

-- GolangciLintFmtArgs builds stable stdin args for golangci-lint fmt.
-- The formatter reads from stdin and emits formatted source to stdout, so the
-- working directory must already point at the project root for config lookup.
local function GolangciLintFmtArgs()
	return { "fmt", "--stdin" }
end

-- NoopLinter disables linting cleanly when no project root can be resolved.
-- This avoids accidentally running golangci-lint from an unrelated cwd.
local function NoopLinter()
	return {
		cmd = "true",
		stdin = true,
		append_fname = false,
		parser = function()
			return {}
		end,
	}
end

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
			linters_by_ft = {
				zsh = { "zsh" },
				go = { "golangcilint" },
				typescript = { "biomejs" },
				javascript = { "biomejs" },
				json = { "biomejs" },
				sql = { "sqlfluff" },
			},
			linters = {
				golangcilint = function()
					local filename = vim.api.nvim_buf_get_name(0)
					local root = GoRoot(filename)
					if not root then
						return NoopLinter()
					end

					local linter = vim.deepcopy(require("lint.linters.golangcilint"))

					-- Force project-root execution so golangci-lint picks up the repository config.
					linter.cwd = root

					return linter
				end,
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
				go = { "golangci_lint_fmt", lsp_format = "never" },
				lua = { "stylua" },
				zsh = { "shfmt" },
				sh = { "shfmt" },
				sql = { "sqlfluff" },
			},
			formatters = {
				golangci_lint_fmt = {
					command = "golangci-lint",
					args = GolangciLintFmtArgs,
					cwd = function(_, ctx)
						return GoRoot(ctx.filename)
					end,
					require_cwd = true,
					stdin = true,
				},
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
