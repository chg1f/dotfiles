-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "]g", function()
	require("gitsigns").nav_hunk("next")
end, { desc = "Next Git Hunk" })

vim.keymap.set("n", "[g", function()
	require("gitsigns").nav_hunk("prev")
end, { desc = "Prev Git Hunk" })
