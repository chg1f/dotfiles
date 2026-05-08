local wezterm = require("wezterm")
local config = {
	adjust_window_size_when_changing_font_size = false,
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

	color_scheme = "Tokyo Night Storm",
	font_size = 12,
	font = wezterm.font_with_fallback({
		-- { family = "JetBrainsMono Nerd Font" },
		{ family = "JetBrainsMonoNL Nerd Font" },
		-- { family = "JetBrains Mono NL" },
		{ family = "Noto Color Emoji" },
		-- { family = "Apple Color Emoji" },
		{ family = "Noto Sans CJK TC" },
		{ family = "Noto Sans CJK SC" },
	}),

	disable_default_key_bindings = true,

	inactive_pane_hsb = {
		saturation = 0.7,
		brightness = 0.55,
	},
	-- colors = {
	-- 	pane_border = "#333333",
	-- 	pane_border_focus = "#7aa2f7",
	-- },

	scrollback_lines = 50000,

	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {
		{ key = "c", mods = "SUPER", action = wezterm.action.CopyTo("Clipboard") },
		{ key = "v", mods = "SUPER", action = wezterm.action.PasteFrom("Clipboard") },

		{ key = "+", mods = "SUPER", action = wezterm.action.IncreaseFontSize },
		{ key = "-", mods = "SUPER", action = wezterm.action.DecreaseFontSize },
		{ key = "0", mods = "SUPER", action = wezterm.action.ResetFontSize },

		{ key = "n", mods = "SUPER", action = wezterm.action.SpawnTab("DefaultDomain") },
		{ key = "w", mods = "SUPER", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
		{ key = "h", mods = "SUPER", action = wezterm.action.ActivateTabRelative(-1) },
		{ key = "l", mods = "SUPER", action = wezterm.action.ActivateTabRelative(1) },

		-- { key = "q", mods = "ALT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
		-- { key = "t", mods = "ALT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
		-- { key = "n", mods = "ALT", action = wezterm.action.ActivateTabRelative(1) },
		-- { key = "p", mods = "ALT", action = wezterm.action.ActivateTabRelative(-1) },
		--
		-- { key = "w", mods = "ALT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
		-- { key = "v", mods = "ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		-- { key = "s", mods = "ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		-- { key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
		-- { key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
		-- { key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
		-- { key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
		--
		-- { key = "m", mods = "ALT", action = wezterm.action.PaneSelect({ mode = "SwapWithActive" }) },
		-- { key = "N", mods = "ALT", action = wezterm.action.MoveTabRelative(1) },
		-- { key = "P", mods = "ALT", action = wezterm.action.MoveTabRelative(-1) },
		--
		-- { key = "f", mods = "ALT", action = wezterm.action.TogglePaneZoomState },
		--
		-- { key = "f", mods = "ALT", action = wezterm.action.TogglePaneZoomState },
		--
		-- { key = "[", mods = "ALT", action = wezterm.action.ActivateCopyMode },
		--
		-- { key = "Space", mods = "LEADER", action = wezterm.action.QuickSelect },
		-- -- quick select urls/words
	},
	-- key_tables = {
	-- 	copy_mode = {
	-- 		{ key = "h", action = wezterm.action.CopyMode("MoveLeft") },
	-- 		{ key = "j", action = wezterm.action.CopyMode("MoveDown") },
	-- 		{ key = "k", action = wezterm.action.CopyMode("MoveUp") },
	-- 		{ key = "l", action = wezterm.action.CopyMode("MoveRight") },
	--
	-- 		{ key = "w", action = wezterm.action.CopyMode("MoveForwardWord") },
	-- 		{ key = "b", action = wezterm.action.CopyMode("MoveBackwardWord") },
	-- 		{ key = "d", mods = "CTRL", action = wezterm.action.CopyMode("PageDown") },
	-- 		{ key = "u", mods = "CTRL", action = wezterm.action.CopyMode("PageUp") },
	-- 		-- { key = "f", mods = "CTRL", action = wezterm.action.CopyMode("PageDown") },
	-- 		-- { key = "b", mods = "CTRL", action = wezterm.action.CopyMode("PageUp") },
	--
	-- 		{ key = "g", action = wezterm.action.CopyMode("MoveToScrollbackTop") },
	-- 		{ key = "G", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToScrollbackBottom") },
	--
	-- 		{ key = "v", action = wezterm.action.CopyMode({ SetSelectionMode = "Cell" }) },
	-- 		{ key = "V", mods = "SHIFT", action = wezterm.action.CopyMode({ SetSelectionMode = "Line" }) },
	--
	-- 		-- { key = "v", action = wezterm.action.CopyMode("SetSelectionMode") },
	-- 		-- { key = "q", action = wezterm.action.CopyMode("ClearSelectionMode") },
	-- 		-- { key = "y", action = wezterm.action.CopyTo("Clipboard") },
	--
	-- 		{ key = "/", action = wezterm.action.Search({ CaseSensitiveString = "" }) },
	-- 		{ key = "n", action = wezterm.action.CopyMode("NextMatch") },
	-- 		{ key = "N", mods = "SHIFT", action = wezterm.action.CopyMode("PriorMatch") },
	--
	-- 		{ key = "Escape", action = wezterm.action.CopyMode("Close") },
	-- 		{ key = "q", action = wezterm.action.CopyMode("Close") },
	-- 		{
	-- 			key = "y",
	-- 			action = wezterm.action.Multiple({
	-- 				wezterm.action.CopyTo("Clipboard"),
	-- 				wezterm.action.CopyMode("Close"),
	-- 			}),
	-- 		},
	-- 	},
	-- 	resize_pane = {},
	-- 	activate_pane = {},
	-- },
}
return config
