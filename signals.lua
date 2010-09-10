-- Signals
-- Awesome modules
local awful	= _G.awful
local client	= _G.client
local beautiful	= _G.beautiful

module("signals")

client.add_signal("manage", function(c, startup)
	-- Enable sloppy focus
	c:add_signal("mouse::enter", function(c)
		if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier and awful.client.focus.filter(c) then
			client.focus = c
		end
	end)

	if not startup then
		-- Set the windows at the slave.
		if not c.size_hints.user_position and not c.size_hints.program_position then
			awful.placement.no_overlap(c)
			awful.placement.no_offscreen(c)
		end
	end
end)

client.add_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.add_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
