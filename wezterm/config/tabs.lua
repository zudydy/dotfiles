local wezterm = require("wezterm")
local appearance = require("config.appearance")

local M = {}

function M.setup(config)
    -- 탭바 기본 설정
    config.enable_tab_bar = true
    config.use_fancy_tab_bar = false
    config.tab_bar_at_bottom = true
    config.hide_tab_bar_if_only_one_tab = false
    config.show_new_tab_button_in_tab_bar = false
    config.tab_max_width = 30
end

function M.setup_events()
    -- 탭 타이틀 포맷팅
    wezterm.on("format-tab-title", function(tab, tabs, panes, config_, hover, max_width)
        local c = appearance.theme_palette()

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

        -- 타이틀 결정
        local title = tab.tab_title
        if not title or #title == 0 then
            title = tab.active_pane and tab.active_pane.title or "wezterm"
        end

        -- pill(양옆 radius) 문자
        local LEFT_EDGE = ""
        local RIGHT_EDGE = ""

        -- index 텍스트(고정 폭으로 계산하기 위해 먼저 문자열로 만듦)
        local index = tab.tab_index + 1
        local index_text = tostring(index)

        -- "절대 잘리면 안 되는" 고정 영역 폭 계산
        local fixed_text = " " .. index_text .. "  " -- title 앞까지 (공백 포함)
        local suffix_text = " "                      -- title 뒤 공백 1개
        local gap_text = " "                         -- 탭 사이 여백

        local reserved = wezterm.column_width(LEFT_EDGE)
            + wezterm.column_width(RIGHT_EDGE)
            + wezterm.column_width(fixed_text)
            + wezterm.column_width(suffix_text)
            + wezterm.column_width(gap_text)

        -- title이 사용할 수 있는 최대 폭(셀 단위)
        local avail = max_width - reserved
        if avail < 0 then
            avail = 0
        end

        -- title은 "가능한 한 길게" (avail만큼 전부 사용)
        local title_cell_width = wezterm.column_width(title)
        if title_cell_width > avail then
            -- avail 셀 안에 들어오도록 자름 (… 포함)
            title = wezterm.truncate_right(title, avail)
        end

        return wezterm.format({
            -- left edge
            { Background = { Color = "transparent" } },
            { Foreground = { Color = bg } },
            { Text = LEFT_EDGE },

            -- body
            { Background = { Color = bg } },
            { Foreground = { Color = fg } },
            { Text = fixed_text .. title .. suffix_text },

            -- right edge (항상 남겨둠)
            { Background = { Color = "transparent" } },
            { Foreground = { Color = bg } },
            { Text = RIGHT_EDGE },

            -- gap
            { Text = gap_text },
        })
    end)
end

function M.setup_style(config)
    local function plus_button(state) -- "default" | "hover"
        local c = appearance.theme_palette()
        local bg = (state == "hover") and c.hover_bg or c.tab_bg
        local fg = c.tab_fg

        return wezterm.format({
            { Background = { Color = c.bar_bg } },
            { Foreground = { Color = bg } },
            { Text = "" },

            { Background = { Color = bg } },
            { Foreground = { Color = fg } },
            { Text = " + " }, -- 여기만 원하는 아이콘/문구로 교체

            { Background = { Color = c.bar_bg } },
            { Foreground = { Color = bg } },
            { Text = "" },

            { Text = " " },
        })
    end

    config.tab_bar_style = {
        new_tab = plus_button("default"),
        new_tab_hover = plus_button("hover"),
    }
end

return M
