-- Calendar to attach to a widget
-- Lua libraries
local io	= _G.io
local os	= _G.os
local math	= _G.math

-- Awesome modules
local awful	= _G.awful
local mouse	= _G.mouse
local naughty	= _G.naughty

-- Our modules
local const	= _G.const

debugfile("Loading calendar.lua")
module("calendar")

local calobj = nil
local offset = 0

local function remove()
	if calobj ~= nil then
		naughty.destroy(calobj)
		cal = nil
		offset = 0
	end
end

local function show(new_offset)
	local save_offset = offset
	remove()
	offset = save_offset + new_offset

	local datespec = os.date("*t")
	datespec = datespec.year * 12 + datespec.month - 1 + offset
	datespec = (datespec % 12 + 1) .. " " .. math.floor(datespec / 12)

	local fcal = io.popen("cal "..datespec)
	local caltext = fcal:read("*a")
	fcal:close()

	-- If we're looking at the current month, 
	-- find and bold/underline the current date.
	if offset == 0 then
		local day = os.date("%d")
		caltext = caltext:gsub(
			("([^%%s]?)%2d "):format(day),
			("%%1<b><u>%2d</u></b> "):format(day)
		)
	end

	-- Remove the extra new lines on the end of cal
	caltext = caltext:gsub("\n+$", "")

	calobj = naughty.notify({
		title = os.date("%a, %d %b %Y"),
		text = ('<tt>%s</tt>'):format(caltext),
		timeout = 0,
		hover_timeout = 0.5,
		width = 160,
		screen = mouse.screen,
	})
end

-- Public function to add the calendar to a given widget
function add(widget)
	widget:connect_signal("mouse::enter", function()
		show(0)
	end)
	widget:connect_signal("mouse::leave", remove)
	widget:buttons(awful.util.table.join(widget:buttons(),
		-- Mouse wheel up
		awful.button({}, const.MOUSE_WHEEL_UP, function()
			show(-1)
		end),
		-- Mouse wheel down
		awful.button({}, const.MOUSE_WHEEL_DN, function()
			show(1)
		end)
	))
end
