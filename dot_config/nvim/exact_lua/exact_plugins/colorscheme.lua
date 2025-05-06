---@class LazyVimPlugin
return {
	{
		"scottmckendry/cyberdream.nvim",
		opts = {
			variant = "dark",
			italic_comments = true,
			-- saturation = 0.8,
			-- overrides = function(colors)
			-- 	return {
			-- 	}
			-- end,
		},
	},
	{
		"ellisonleao/gruvbox.nvim",
		opts = {
			contrast = "hard",
		},
	},
	{
		"catppuccin/nvim",
		opts = {
			flavour = "mocha",
		},
	},
	{
		"folke/tokyonight.nvim",
	},
}
