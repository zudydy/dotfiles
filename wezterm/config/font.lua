local wezterm = require("wezterm")

local M = {}

function M.setup(config)
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
end

return M
