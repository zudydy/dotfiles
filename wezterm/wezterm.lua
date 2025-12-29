local wezterm = require("wezterm")

-- 모듈 임포트
local appearance = require("config.appearance")
local font = require("config.font")
local window = require("config.window")
local keybinds = require("config.keybinds")
local tabs = require("config.tabs")

-- 설정 객체 생성
local config = wezterm.config_builder()

-- 각 모듈 설정 적용
appearance.setup(config)
font.setup(config)
window.setup(config)
keybinds.setup(config)
tabs.setup(config)

-- 이벤트 설정
window.setup_events()
tabs.setup_events()

-- 탭바 스타일 설정
tabs.setup_style(config)

return config
