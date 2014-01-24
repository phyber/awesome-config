-- Build menus
-- Awesome modules
local awful	= _G.awful
local awesome	= _G.awesome
local beautiful	= _G.beautiful

-- Our modules
local settings	= _G.settings

debugfile("Loading menu.lua")
module("menu")

awesomemenu = {
	{
		"edit config", 
		("%s %s/rc.lua"):format(settings.editor_cmd, awful.util.getdir("config"))
	},
	{
		"restart",
		awesome.restart
	},
}

mainmenu = awful.menu({
	items = {
		{ "awesome",	awesomemenu, beautiful.awesome_icon },
		{ "terminal",	settings.terminal },
		{ "browser",	settings.browser },
	}
})
