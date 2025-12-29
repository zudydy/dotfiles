local wezterm = require("wezterm")

local M = {}

function M.scheme_for_appearance(appearance)
    if appearance:find("Dark") then
        return "catppuccin-frappe"
    else
        return "catppuccin-latte"
    end
end

function M.is_theme_dark()
    return wezterm.gui.get_appearance():find("Dark") ~= nil
end

function M.theme_palette()
    if M.is_theme_dark() then
        return {
            bar_bg = "#303446",
            tab_bg = "#414559",
            tab_fg = "#C6D0F5",
            active_bg = "#C6D0F5",
            active_fg = "#303446",
            hover_bg = "#51576D",
        }
    else
        return {
            bar_bg = "#E6E8EF",
            tab_bg = "#DCE0E8",
            tab_fg = "#4C4F69",
            active_bg = "#4C4F69",
            active_fg = "#EFF1F5",
            hover_bg = "#CCD0DA",
        }
    end
end

function M.setup(config)
    config.color_scheme = M.scheme_for_appearance(wezterm.gui.get_appearance())

    -- 커스텀 배경색 설정
    config.colors = {
        background = "#E6E8EF",
    }
    config.colors.tab_bar = {
        background = "transparent",
    }
end

return M
