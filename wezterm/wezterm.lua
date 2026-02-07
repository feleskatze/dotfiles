-- wezterm.lua
local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- 見た目
config.color_scheme = "Gruvbox Dark (Gogh)"
config.font = wezterm.font_with_fallback({
  "UDEV Gothic 35NFLG",
})
config.font_size = 10.0
config.line_height = 1

-- 余白
config.window_padding = { left = 10, right = 10, top = 10, bottom = 10 }

-- タブ
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- 体感を軽く
config.animation_fps = 60
config.max_fps = 120
config.front_end = "WebGpu" -- だめなら "OpenGL" にする

-- Git Bash をデフォルト起動（Windows）
-- 典型パス：C:\Program Files\Git\bin\bash.exe
config.default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe", "-l" }

-- キー
config.keys = {
  -- コピー/ペースト
  { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
  { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

  -- 分割
  { key = "d", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "D", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

  -- ペイン移動（Ctrl+Shift+矢印）
  { key = "LeftArrow",  mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "UpArrow",    mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "DownArrow",  mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
}

return config
