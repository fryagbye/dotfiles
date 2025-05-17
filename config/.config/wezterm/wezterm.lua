-- weztermのAPIを読み込み
local wezterm = require("wezterm")

-- 設定のビルダーを作成
local config = wezterm.config_builder()

-- カラースキームの設定
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#706b4e",
	selection_fg = "#f3d9c4",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

-- フォント設定
config.font = wezterm.font("SF Mono Square", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.font_size = 18 -- デフォルトフォントサイズ
-- config.dpi = 144
config.enable_tab_bar = false
config.window_background_opacity = 0.8
config.macos_window_background_blur = 8

-- DPIに基づいてフォントサイズを調整する関数
local dpi_change_num = 96
local dpi_change_font_size = 20
local prev_dpi = 0

wezterm.on("window-focus-changed", function(window, pane)
	-- 現在のdpiを取得
	local dpi = window:get_dimensions().dpi

	if dpi == prev_dpi then
		return
	end

	local overrides = window:get_config_overrides() or {}
	-- dpiが96以上の時はフォントサイズを13pxにする
	overrides.font_size = dpi >= dpi_change_num and dpi_change_font_size or nil
	window:set_config_overrides(overrides)
	wezterm.log_info("Current DPI: " .. dpi)
	prev_dpi = dpi
end)

-- 設定を返す
return config -- Pull in the wezterm API
