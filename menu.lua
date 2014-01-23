-- Build menus
-- Lua libraries
local string	= _G.string
-- Awesome modules
local awful	= _G.awful
--local debian = {
--	menu	= require "debian.menu"
--}
local awesome	= _G.awesome
local beautiful	= _G.beautiful

-- Our modules
local settings	= _G.settings

debugfile("Loading menu.lua")
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
		{ "awesome",	awesomemenu, beautiful.awesome_icon },
		--{ "Debian",	debian.menu.Debian_menu.Debian },
		{ "terminal",	settings.terminal },
		{ "browser",	settings.browser },
	}
})

--[[
if type(settings.menuitems) == "table" and #settings.menuitems > 0 then
	for name, cmd in pairs(settings.menuitems) do 
		mainmenu = awful.util.table.join(mainmenu, 
end
--]]
