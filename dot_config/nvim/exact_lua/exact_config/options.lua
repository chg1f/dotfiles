-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false
vim.g.minipairs_disable = true

vim.opt.mouse = ""
-- vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.list = true
vim.opt.listchars = {
	eol = "↩",
	trail = "·",
	multispace = "· ",
	tab = "→ ",
	extends = "»",
	precedes = "«",
}

vim.opt.relativenumber = false
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"

vim.g.bigfile_size = 500 * 1024 -- 500 KB

-- vim.opt.foldclose = ""
-- vim.opt.viewoptions:remove("folds")
-- vim.opt.sessionoptions:remove("folds")
