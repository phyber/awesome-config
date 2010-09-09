-- Autostart.
local awful = _G.awful
local settings = _G.settings
local type = _G.type
local pairs = _G.pairs

module("autostart")

if type(settings.autostart) ~= "table" then
	return
end

for k, v in pairs(settings.autostart) do
	awful.util.spawn_with_shell(v)
end
