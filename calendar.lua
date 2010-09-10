-- Calendar to attach to a widget
local awful = _G.awful
local naughty = _G.naughty
local mouse = _G.mouse
local string = _G.string
local math = _G.math
local os = _G.os
local io = _G.io

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
		caltext = string.gsub(
			caltext,
			string.format(" %2d ", day),
			string.format(" <b><u>%2d</u></b> ", day)
		)
	end

	-- Remove the extra new lines on the end of cal
	caltext = string.gsub(caltext, "\n+$", "")

	calobj = naughty.notify({
		title = string.format(
			'<tt><b>%s</b></tt>',
			os.date("%a, %d %b %Y")
		),
		text = string.format(
			'<tt>%s</tt>',
			caltext
		),
		timeout = 0,
		hover_timeout = 0.5,
		width = 150,
		screen = mouse.screen,
	})
end

-- Public function to add the calendar to a given widget
function add(widget)
	widget:add_signal("mouse::enter", function()
		show(0)
	end)
	widget:add_signal("mouse::leave", remove)
	widget:buttons(awful.util.table.join(
		-- Mouse wheel up
		awful.button({}, 4, function()
			show(-1)
		end),
		-- Mouse wheel down
		awful.button({}, 5, function()
			show(1)
		end)
	))
end
