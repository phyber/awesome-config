-- Build menus

local os = os
local awful = _G.awful
local debian = {
	menu = require "debian.menu"
}
local string = string
local awesome = _G.awesome
local beautiful = _G.beautiful

module("menu")

-- XXX: These should probably be in a settings.lua
terminal = "uxterm"
browser = "google-chrome"
homedir = os.getenv("HOME")
editor = os.getenv("EDITOR") or "vim"
editor_cmd = string.format("%s -e %s", terminal, editor)

awesomemenu = {
	{
		"edit config", 
		string.format("%s %s/rc.lua", editor_cmd, awful.util.getdir("config"))
	},
	{
		"restart",
		awesome.restart
	},
}

mainmenu = awful.menu({
	items = {
		{ "awesome", awesomemenu, beautiful.awesome_icon },
		{ "Debian", debian.menu.Debian_menu.Debian },
		{ "terminal", terminal },
		{ "browser", browser },
	}
})
