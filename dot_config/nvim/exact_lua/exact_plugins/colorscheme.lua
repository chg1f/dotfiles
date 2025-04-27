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
				bg = "#141414",
				bg_alt = "#31322c",
				bg_highlight = "#3c4048",
				fg = "#fffef8",

				gray = "#5c4f55",
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
