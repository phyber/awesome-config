-- Settings used elsewhere in the config.
-- TODO: Group the settings so this file makes more sense.
-- Lua libraries.
local os = _G.os
debugfile("Loading settings.lua")
module("settings")

homedir = os.getenv("HOME")
modkey = "Mod4"
theme = homedir .. "/.config/awesome/current_theme.lua"
wallpaper = homedir .. "/.wallpaper/hudf.jpg"

-- These appear on the top level of the right-click menu.
-- No support for large trees of stuff yet.
menuitems = {
	terminal	= "urxvt",
	browser		= "/usr/bin/firefox",
}

-- Old entries.
terminal = menuutems.terminal
browser = menuitems.browser
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

autostart = {
	--["XScreenSaver"] = "xscreensaver -no-splash &",
}

-- Network widget setting.
netif = "eth0"

-- How shall we lock the screen when Shift-Clicking the clock?
lockscreen = "slock"

-- Media keys
mediakeys = {
	["XF86AudioPlay"]		= "mocp --toggle-pause",
	["XF86AudioPrev"]		= "mocp --previous",
	["XF86AudioNext"]		= "mocp --next",
	["XF86AudioMute"]		= "amixer -q sset Master toggle",
	["XF86AudioRaiseVolume"]	= "amixer -q sset Master 1dB+",
	["XF86AudioLowerVolume"]	= "amixer -q sset Master 1dB-",
}
