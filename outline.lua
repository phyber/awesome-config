-- Layouts
-- Awesome modules
local awful	= _G.awful
local screen	= _G.screen

debugfile("Loading outline.lua")
module("outline")

-- Available layouts
layouts = {
	awful.layout.suit.floating,		-- 1
	awful.layout.suit.tile,			-- 2
	awful.layout.suit.tile.left,		-- 3
	awful.layout.suit.tile.bottom,		-- 4
	awful.layout.suit.tile.top,		-- 5
	awful.layout.suit.fair,			-- 6
	awful.layout.suit.fair.horizontal,	-- 7
	awful.layout.suit.spiral,		-- 8
	awful.layout.suit.spiral.dwindle,	-- 9
	awful.layout.suit.max,			-- 10
	awful.layout.suit.max.fullscreen,	-- 11
	awful.layout.suit.magnifier,		-- 12
}

-- Screen layouts
tags = {}
for s = 1, screen.count() do
	-- Left monitor
	if s == 1 then
		tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[2])
	-- Right monitor
	elseif s == 2 then
		tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[5])
	-- Contingency plan.
	else
		tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
	end
end
