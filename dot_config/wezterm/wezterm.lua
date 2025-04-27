local wezterm = require("wezterm")
local config = {
	initial_cols = 100,
	initial_rows = 30,

	automatically_reload_config = true,
	exit_behavior = "CloseOnCleanExit",
	exit_behavior_messaging = "Verbose",

	window_close_confirmation = "NeverPrompt",
	window_padding = { left = 5, right = 5, top = 5, bottom = 5 },

	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,

	animation_fps = 60,
	max_fps = 60,
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",

	-- color_scheme = "GruvboxDark",
	colors = {
		foreground = "#EEEAD9",
		background = "#141414",
		ansi = {
			"#31322C",
			"#AB1D22",
			"#2A6E3F",
			"#D6BC46",
			"#06436F",
			"#6C216D",
			"#108B96",
			"#ECEBC2",
		},
		brights = {
			"#5C4F55",
			"#D24735",
			"#6A8D52",
			"#F2C867",
			"#106898",
			"#A6559D",
			"#87C0CA",
			"#F6F9E4",
		},
	},
	font_size = 12,
	font = wezterm.font_with_fallback({
		{ family = "JetBrains Mono NL" },
		{ family = "Noto Sans CJK TC" },
		{ family = "Noto Sans CJK SC" },
		{ family = "Noto Emoji" },
	}),

	disable_default_key_bindings = true,
	keys = {
		{ key = "c", mods = "SUPER", action = wezterm.action.CopyTo("Clipboard") },
		{ key = "v", mods = "SUPER", action = wezterm.action.PasteFrom("Clipboard") },

		{ key = "+", mods = "SUPER", action = wezterm.action.IncreaseFontSize },
		{ key = "-", mods = "SUPER", action = wezterm.action.DecreaseFontSize },
		{ key = "0", mods = "SUPER", action = wezterm.action.ResetFontSize },

		{ key = "t", mods = "SUPER", action = wezterm.action.SpawnTab("DefaultDomain") },
		{ key = "w", mods = "SUPER", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
		{ key = "[", mods = "SUPER", action = wezterm.action.ActivateTabRelative(-1) },
		{ key = "]", mods = "SUPER", action = wezterm.action.ActivateTabRelative(1) },
	},
	-- mouse_bindi,ngs = {
	--   {
	--     event = { Up = { streak = 1, button = "Left" } },
	--     mods = "CTRL",
	--     action = wezterm.action.OpenLinkAtMouseCursor,
	--   },
	-- },
}
return config
