---@class LazyVimPlugin
return {
	{
		"rktjmp/lush.nvim",
		cmd = "Lushify",
	},
	{
		"scottmckendry/cyberdream.nvim",
		opts = {
			highlights = function(colors)
				return {
					Operator = { fg = colors.white },
				}
			end,
			colors = {
				bg = "#000000",
				fg = "#ffffff",

				gray = "#31322c",
				red = "#c12c1f",
				green = "#4f6f46",
				yellow = "#d6c560",
				blue = "#2e59a7",
				purple = "#814662",
				cyan = "#8aabcc",
				white = "#d5c8a0",
				magenta = "#b83570",
				pink = "#dd7694",
				orange = "#ea5514",
			},
		},
	},
	{
		"ellisonleao/gruvbox.nvim",
		opts = {
			contrast = "hard",
		},
	},
	{ "EdenEast/nightfox.nvim" },
	{ "rose-pine/neovim" },
	{ "rebelot/kanagawa.nvim" },
}
