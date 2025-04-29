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
				red = "#ab1d22",
				green = "#2a6e4f",
				yellow = "#d6bc46",
				blue = "#06436f",
				purple = "#6c216d",
				cyan = "#108b96",
				white = "#ede1c9",
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
