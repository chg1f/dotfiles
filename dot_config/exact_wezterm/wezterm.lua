local wezterm = require("wezterm")
local config = {
	automatically_reload_config = true,
	exit_behavior = "CloseOnCleanExit",
	exit_behavior_messaging = "Verbose",

	animation_fps = 60,
	max_fps = 60,
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",

	-- color_scheme = "Tokyo Night",
	color_scheme = "GruvboxDarkHard",
	font = wezterm.font_with_fallback({
		{ family = "JetBrains Mono NL" },
		{ family = "Noto Sans CJK TC" },
		{ family = "Noto Sans CJK SC" },
		{ family = "Noto Emoji" },
	}),
	font_size = 12.0,

	window_close_confirmation = "NeverPrompt",
	window_padding = { left = 0.5, right = 0.5, top = 0.5, bottom = 0.5 },

	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = true,
	-- show_close_tab_button_in_tabs = true,
	-- show_new_tab_button_in_tab_bar = true,
	-- switch_to_last_active_tab_when_closing_tab = true,

	disable_default_key_bindings = true,
	keys = {
		{ key = "c", mods = "SUPER", action = wezterm.action.CopyTo("Clipboard") },
		{ key = "v", mods = "SUPER", action = wezterm.action.PasteFrom("Clipboard") },

		{ key = "+", mods = "SUPER", action = wezterm.action.IncreaseFontSize },
		{ key = "-", mods = "SUPER", action = wezterm.action.DecreaseFontSize },
		{ key = "0", mods = "SUPER", action = wezterm.action.ResetFontSize },

		{ key = "c", mods = "SUPER", action = wezterm.action.SpawnTab("DefaultDomain") },
		{ key = "w", mods = "SUPER", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
		{ key = "p", mods = "SUPER", action = wezterm.action.ActivateTabRelative(-1) },
		{ key = "n", mods = "SUPER", action = wezterm.action.ActivateTabRelative(1) },
	},
	-- mouse_bindings = {
	--   {
	--     event = { Up = { streak = 1, button = "Left" } },
	--     mods = "CTRL",
	--     action = wezterm.action.OpenLinkAtMouseCursor,
	--   },
	-- },
}
return config
