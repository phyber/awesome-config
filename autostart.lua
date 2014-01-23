-- Autostart.
-- Lua libraries.
local type = _G.type
local pairs = _G.pairs

-- Awesome modules
local awful = _G.awful

-- Our modules
local settings = _G.settings

debugfile("Loading autostart.lua")
module("autostart")

if type(settings.autostart) == "table" then
	for k, v in pairs(settings.autostart) do
		awful.util.spawn_with_shell(v)
	end
end
