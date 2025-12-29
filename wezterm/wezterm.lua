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
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false


config.font = wezterm.font_with_fallback({
	{
		family = "JetBrains Mono",
		weight = 500,
	},
	{
		family = "MesloLGS NF",
		weight = "Regular",
	},
})
config.font_size = 12
config.line_height = 1.1

function scheme_for_appearance(appearance)
	if appearance:find "Dark" then
	  return "catppuccin-frappe"
	else
	  return "catppuccin-latte"
	end
  end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

-- 커스텀 배경색 설정
config.colors = {
	background = "#E6E8EF",
}
config.colors.tab_bar = {
  background = "transparent",
}

config.window_background_opacity = 0.8
config.macos_window_background_blur = 100

config.window_padding = {
	top = 0,
}

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

wezterm.on("format-tab-title", function(tab, tabs, panes, config_, hover, max_width)
	-- ===== 팔레트(너가 쓰던 거 그대로 두고, 여기선 예시만) =====
	local function is_dark()
	  return wezterm.gui.get_appearance():find("Dark") ~= nil
	end
  
	local c
	if is_dark() then
	  c = {
		bar_bg = "#303446",
		tab_bg = "#414559",
		tab_fg = "#C6D0F5",
		active_bg = "#C6D0F5",
		active_fg = "#303446",
		hover_bg = "#51576D",
	  }
	else
	  c = {
		bar_bg = "#E6E8EF",
		tab_bg = "#DCE0E8",
		tab_fg = "#4C4F69",
		active_bg = "#4C4F69",
		active_fg = "#EFF1F5",
		hover_bg = "#CCD0DA",
	  }
	end
  
	local active = tab.is_active
	local bg = c.tab_bg
	local fg = c.tab_fg
	if active then
	  bg = c.active_bg
	  fg = c.active_fg
	elseif hover then
	  bg = c.hover_bg
	  fg = c.tab_fg
	end
  
	-- ===== 타이틀 결정 =====
	local title = tab.tab_title
	if not title or #title == 0 then
	  title = tab.active_pane and tab.active_pane.title or "wezterm"
	end
  
	-- ===== pill(양옆 radius) 문자 =====
	local LEFT_EDGE  = ""
	local RIGHT_EDGE = ""
  
	-- index 텍스트(고정 폭으로 계산하기 위해 먼저 문자열로 만듦)
	local index = tab.tab_index + 1
	local index_text = tostring(index)
  
	-- ===== “절대 잘리면 안 되는” 고정 영역 폭 계산 =====
	-- 최종 렌더 형태:
	-- bar_bg + LEFT_EDGE + [ " " .. index .. "  " .. title .. " " ] + RIGHT_EDGE + " "
	local fixed_text = " " .. index_text .. "  "      -- title 앞까지 (공백 포함)
	local suffix_text = " "                           -- title 뒤 공백 1개
	local gap_text = " "                              -- 탭 사이 여백
  
	local reserved =
	  wezterm.column_width(LEFT_EDGE) +
	  wezterm.column_width(RIGHT_EDGE) +
	  wezterm.column_width(fixed_text) +
	  wezterm.column_width(suffix_text) +
	  wezterm.column_width(gap_text)
  
	-- title이 사용할 수 있는 최대 폭(셀 단위)
	local avail = max_width - reserved
	if avail < 0 then
	  avail = 0
	end
  
	-- title은 “가능한 한 길게” (avail만큼 전부 사용)
	-- 너무 작으면 최소 1셀이라도 보여주고 싶으면 1로 두면 됨
	local title_cell_width = wezterm.column_width(title)
	if title_cell_width > avail then
	  -- avail 셀 안에 들어오도록 자름 (… 포함)
	  title = wezterm.truncate_right(title, avail)
	end
  
	return wezterm.format({
	  -- left edge
	  { Background = { Color = c.bar_bg } },
	  { Foreground = { Color = bg } },
	  { Text = LEFT_EDGE },
  
	  -- body
	  { Background = { Color = bg } },
	  { Foreground = { Color = fg } },
	  { Text = fixed_text .. title .. suffix_text },
  
	  -- right edge (항상 남겨둠)
	  { Background = { Color = c.bar_bg } },
	  { Foreground = { Color = bg } },
	  { Text = RIGHT_EDGE },
  
	  -- gap
	  { Text = gap_text },
	})
  end)
  

return config
