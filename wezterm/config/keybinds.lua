local wezterm = require("wezterm")

local M = {}

function M.setup(config)
	config.keys = {
		-- 탭/패널 닫기
		{
			key = "w",
			mods = "CMD",
			action = wezterm.action.EmitEvent("close-pane-or-tab"),
		},

		-- 패널 분할
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

		-- 패널 간 이동
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

		-- 텍스트 편집 단축키
		{
			key = "Backspace",
			mods = "CMD",
			action = wezterm.action.SendKey({
				key = "u",
				mods = "CTRL", -- Ctrl+U = kill-line (Unix 스타일)
			}),
		},
		{
			key = "Backspace",
			mods = "OPT",
			action = wezterm.action.SendKey({
				key = "w",
				mods = "CTRL", -- Ctrl+W = backward-kill-word
			}),
		},

		-- 커서 이동
		{
			key = "LeftArrow",
			mods = "CMD",
			action = wezterm.action.SendKey({
				key = "a",
				mods = "CTRL",
			}),
		},
		{
			key = "RightArrow",
			mods = "CMD",
			action = wezterm.action.SendKey({
				key = "e",
				mods = "CTRL",
			}),
		},
		{
			key = "LeftArrow",
			mods = "OPT",
			action = wezterm.action.SendKey({
				key = "b",
				mods = "ALT",
			}),
		},
		{
			key = "RightArrow",
			mods = "OPT",
			action = wezterm.action.SendKey({
				key = "f",
				mods = "ALT",
			}),
		},
	}
end

return M
