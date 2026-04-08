-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local go_folds = vim.api.nvim_create_augroup("go_folds", { clear = true })

local function disable_go_folds(buf, win)
	vim.bo[buf].foldmethod = "manual"
	vim.bo[buf].foldexpr = "0"
	vim.wo[win].foldenable = false
end

vim.api.nvim_create_autocmd("FileType", {
	group = go_folds,
	pattern = "go",
	callback = function(args)
		disable_go_folds(args.buf, vim.api.nvim_get_current_win())
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = go_folds,
	pattern = "*.go",
	callback = function(args)
		disable_go_folds(args.buf, vim.api.nvim_get_current_win())
	end,
})
