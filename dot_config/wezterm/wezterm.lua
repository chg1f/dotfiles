local wezterm = require("wezterm")
return {
  font = wezterm.font_with_fallback({
    { family = "JetBrains Mono NL" },
    { family = "Noto Color Emoji" },
  }),
  color_scheme = "Tokyo Night",
  window_close_confirmation = "AlwaysPrompt",
  exit_behavior = "CloseOnCleanExit",
  hide_tab_bar_if_only_one_tab = true,
  disable_default_key_bindings = true,
  keys = {
    { key = "c", mods = "SUPER", action = wezterm.action.CopyTo("Clipboard") },
    { key = "v", mods = "SUPER", action = wezterm.action.PasteFrom("Clipboard") },
    { key = "+", mods = "SUPER", action = wezterm.action.IncreaseFontSize },
    { key = "-", mods = "SUPER", action = wezterm.action.DecreaseFontSize },
    { key = "0", mods = "SUPER", action = wezterm.action.ResetFontSize },
  },
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
  },
}
