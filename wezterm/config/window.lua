local wezterm = require("wezterm")

local M = {}

function M.setup(config)
    -- 윈도우 기본 설정
    config.automatically_reload_config = true
    config.window_close_confirmation = "NeverPrompt"
    config.window_decorations = "RESIZE"

    -- 배경 및 투명도 설정
    config.window_background_opacity = 0.8
    config.macos_window_background_blur = 100

    -- 윈도우 패딩
    config.window_padding = {
        top = 0,
    }

    -- 비활성 패널 설정
    config.inactive_pane_hsb = {
        saturation = 1.0,
        brightness = 1.0,
    }

    -- 커서 및 스크롤백 설정
    config.default_cursor_style = "BlinkingBar"
    config.scrollback_lines = 1000000
end

function M.setup_events()
    local mux = wezterm.mux

    -- GUI 시작 시 윈도우 최대화
    wezterm.on("gui-startup", function()
        local tab, pane, window = mux.spawn_window({})
        window:gui_window():maximize()
    end)

    -- 패널/탭 닫기 이벤트
    wezterm.on("close-pane-or-tab", function(window, pane)
        local tab = window:active_tab()
        local panes = tab:panes()

        if #panes > 1 then
            window:perform_action(wezterm.action.CloseCurrentPane({ confirm = false }), pane)
        else
            window:perform_action(wezterm.action.CloseCurrentTab({ confirm = false }), pane)
        end
    end)
end

return M
