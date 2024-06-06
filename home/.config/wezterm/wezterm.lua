local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local fonts = {
    "JetBrainsMono Nerd Font Mono",
	"Geist Mono",
	"SF Mono",
	"Monaspace Neon",
	"Monaspace Xenon",
	"Monaspace Krypton",
	"Monaspace Radon",
	"Monaspace Argon",
	"Comic Code Ligatures",
	-- "Liga SFMono Nerd Font",
	-- "Fira Code Retina",
	-- "DankMono Nerd Font",
	-- "Monego Ligatures",
	-- "Operator Mono Lig",
	-- "Gintronic",
	-- "Cascadia Code",
	-- "Victor Mono",
	-- "Inconsolata",
	-- "TempleOS",
	-- "Apercu Pro",
}
local emoji_fonts = { "Apple Color Emoji", "Joypixels", "Twemoji", "Noto Color Emoji", "Noto Emoji" }

-- https://www.monolisa.dev/playground
-- https://fontdrop.info/#/?darkmode=true
-- https://helpx.adobe.com/fonts/using/open-type-syntax.html
-- SF Mono
-- config.harfbuzz_features =
-- 	{ "-c2sc", "liga", "ccmp", "locl", "-smcp", "-ss03", "-ss04", "ss05", "ss06", "ss07", "-ss08", "-ss09" }
-- Fira Code
-- https://github.com/tonsky/FiraCode/wiki/How-to-enable-stylistic-sets
-- config.harfbuzz_features = { "cv01", "cv02", "cv06", "cv10", "cv13", "ss01", "ss04", "ss05", "ss02" }
-- monaspace
-- config.harfbuzz_features =
-- 	{ "calt", "liga", "dlig", "zero", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" }
-- geist /> === // 0O
-- config.harfbuzz_features =
-- 	{ "calt", "liga", "dlig", "zero", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "-ss09" }
-- monolisa
-- @ <=0xF \\ \n
config.harfbuzz_features =
	{ "calt", "liga", "zero", "-ss01", "ss02", "-ss03", "ss04", "ss05", "-ss06", "-ss07", "-ss08", "-ss09", "ss10", "ss11", "ss12", "-ss13", "ss14", "ss15", "ss16", "ss17", "ss18" }
config.font = wezterm.font_with_fallback({ fonts[1], emoji_fonts[1], emoji_fonts[2] })
-- config.disable_default_key_bindings = true
config.front_end = "WebGpu"
config.enable_scroll_bar = false
config.scrollback_lines = 1000000
config.font_size = 14
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.automatically_reload_config = true
config.default_cursor_style = "BlinkingBar"
config.initial_cols = 250
config.initial_rows = 50
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
-- config.window_decorations = "RESIZE|TITLE"
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}
config.window_frame = {
	font = wezterm.font({ family = "JetBrainsMono Nerd Font Mono" }),
	active_titlebar_bg = "#1e1e1e",
	inactive_titlebar_bg = "#1e1e1e",
	font_size = 14.0,
}

config.color_scheme = "OneDark (base16)"
config.color_scheme = "OneDark"
config.color_schemes = {
	["OneDark"] = {
		foreground = "#f0f6fc",
		background = "#1e1e1e",
		-- background = "#21262d",
		-- background = "#1e1e2e",
		-- background = "#1a1b26",
		cursor_bg = "#b1cad8",
		cursor_fg = "#21262d",
		cursor_border = "#CF7277",
		selection_fg = "#21262d",
		selection_bg = "#2A4668",
		scrollbar_thumb = "#30363d",
		split = "#6e7681",

		ansi = {
			"#8b949e",
			"#ff7b72",
			"#aff5b4",
			"#FFE08C",
			"#79c0ff",
			"#d2a8ff",
			"#a5d6ff",
			"#c9d1d9",
		},
		brights = {

			"#8b949e",
			"#ff7b72",
			"#aff5b4",
			"#FFE08C",
			"#79c0ff",
			"#d2a8ff",
			"#a5d6ff",
			"#c9d1d9",
		},
	},
}

config.colors = {
	tab_bar = {
		background = "#808080",
		 inactive_tab = {
			bg_color = "#1e1e1e",
			fg_color = "#c8c8c8",
		},
		active_tab = {
			bg_color = "#30363d",
			fg_color = "#8b949e",
		},
		inactive_tab_hover = {
			bg_color = "#484f58",
			fg_color = "#b1bac4",
		},
		new_tab = {
			bg_color = "#30363d",
			fg_color = "#8b949e",
		},
		new_tab_hover = {
			bg_color = "#484f58",
			fg_color = "#b1bac4",
		},
	},
}

-- local act = wezterm.action
--
-- config.keys = {
-- 	{ key = "h", mods = "ctrl", action = act.ActivateTabRelative(-1) },
-- 	{ key = "l", mods = "ctrl", action = act.ActivateTabRelative(1) },
-- }

return config
