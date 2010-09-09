-- Build menus

local os = os
local awful = _G.awful
local debian = {
	menu = require "debian.menu"
}
local string = string
local awesome = _G.awesome
local beautiful = _G.beautiful
local settings = _G.settings

module("menu")

awesomemenu = {
	{
		"edit config", 
		string.format("%s %s/rc.lua", settings.editor_cmd, awful.util.getdir("config"))
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
		{ "terminal", settings.terminal },
		{ "browser", settings.browser },
	}
})
