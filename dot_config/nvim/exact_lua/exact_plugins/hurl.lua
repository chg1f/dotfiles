return {
	{
		"jellydn/hurl.nvim",
		ft = "hurl",
		dependencies = { "MunifTanjim/nui.nvim" }, -- 插件常用 UI 依赖
		keys = {
			{ "<leader>hr", "<cmd>HurlRunnerAtCursor<CR>", desc = "Hurl: run request at cursor", ft = "hurl" },
			{ "<leader>hR", "<cmd>HurlRunner<CR>", desc = "Hurl: run file", ft = "hurl" },
		},
	},
}
