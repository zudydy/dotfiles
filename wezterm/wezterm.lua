local wezterm = require("wezterm")

local config = wezterm.config_builder()

local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

config.automatically_reload_config = true

config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

config.font = wezterm.font_with_fallback({
	{
		family = "JetBrains Mono",
		weight = "Bold",
	},
	{
		family = "MesloLGS NF",
		weight = "Regular",
	},
})
config.font_size = 12

config.color_scheme = "catppuccin-frappe"
config.window_background_opacity = 0.9
config.macos_window_background_blur = 50

-- config.enable_tab_bar = false

config.inactive_pane_hsb = {
	saturation = 1.0,
	brightness = 1.0,
}

config.default_cursor_style = "BlinkingBar"

config.scrollback_lines = 1000000

wezterm.on("close-pane-or-tab", function(window, pane)
	local tab = window:active_tab()
	local panes = tab:panes()

	if #panes > 1 then
		window:perform_action(wezterm.action.CloseCurrentPane({ confirm = false }), pane)
	else
		window:perform_action(wezterm.action.CloseCurrentTab({ confirm = false }), pane)
	end
end)

config.keys = {
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.EmitEvent("close-pane-or-tab"),
	},

	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "D",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "LeftArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},

	{
		key = "Backspace",
		mods = "CMD",
		action = wezterm.action.SendKey({
			key = "u",
			mods = "CTRL", -- Ctrl+U = kill-line (Unix 스타일)
		}),
	},

	-- ⌥ + ⌫ → 단어 삭제 (backward-kill-word)
	{
		key = "Backspace",
		mods = "OPT",
		action = wezterm.action.SendKey({
			key = "w",
			mods = "CTRL", -- Ctrl+W = backward-kill-word
		}),
	},
	-- ⌘ + ← : 커서 줄 맨 앞으로 이동 (Ctrl-A)
	{
		key = "LeftArrow",
		mods = "CMD",
		action = wezterm.action.SendKey({
			key = "a",
			mods = "CTRL",
		}),
	},

	-- ⌘ + → : 커서 줄 맨 끝으로 이동 (Ctrl-E)
	{
		key = "RightArrow",
		mods = "CMD",
		action = wezterm.action.SendKey({
			key = "e",
			mods = "CTRL",
		}),
	},

	-- ⌥ + ← : 이전 단어로 이동 (Ctrl-B 단어 단위)
	{
		key = "LeftArrow",
		mods = "OPT",
		action = wezterm.action.SendKey({
			key = "b",
			mods = "ALT",
		}),
	},

	-- ⌥ + → : 다음 단어로 이동 (Ctrl-F 단어 단위)
	{
		key = "RightArrow",
		mods = "OPT",
		action = wezterm.action.SendKey({
			key = "f",
			mods = "ALT",
		}),
	},
}

return config
