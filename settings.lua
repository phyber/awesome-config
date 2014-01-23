-- Settings used elsewhere in the config.
-- TODO: Group the settings so this file makes more sense.
-- Lua libraries.
local os = _G.os
debugfile("Loading settings.lua")
module("settings")

homedir = os.getenv("HOME")
modkey = "Mod4"
theme = homedir .. "/.config/awesome/current_theme.lua"
--wallpaper = homedir .. "/.wallpaper/battlecry-dual-1680x1050.jpg"
wallpaper = homedir .. "/.wallpaper/hudf.jpg"
--wallpaper = {}
-- These appear on the top level of the right-click menu.
-- No support for large trees of stuff yet.
menuitems = {
	terminal	= "uxterm",
	browser		= "google-chrome",
}

-- Old entries.
terminal = "urxvt"
browser = "chromium"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

autostart = {
	--["XScreenSaver"] = "xscreensaver -no-splash &",
}

-- Network widget setting.
netif = "eth0"

-- How shall we lock the screen when Shift-Clicking the clock?
lockscreen = "xscreensaver-command -lock"

-- Media keys
mediakeys = {
	["XF86AudioPlay"]		= "mocp --toggle-pause",
	["XF86AudioPrev"]		= "mocp --previous",
	["XF86AudioNext"]		= "mocp --next",
	["XF86AudioMute"]		= "amixer -q sset Master toggle",
	["XF86AudioRaiseVolume"]	= "amixer -q sset Master 5%+",
	["XF86AudioLowerVolume"]	= "amixer -q sset Master 5%-",
}
