-- Calendar to attach to a widget
local awful = _G.awful
local naughty = _G.naughty
local mouse = _G.mouse
local string = _G.string
local math = _G.math
local os = _G.os
local io = _G.io
local perror = _G.perror
local type = _G.type

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
	datespec = datespec.year * 12 + datespec.month -1 + offset
	datespec = (datespec % 12 + 1) .. " " .. math.floor(datespec / 12)
	local fcal = io.popen("cal "..datespec)
	local caltext = ""
	local day = string.format(" %2d ", os.date("%d"))
	for line in fcal:lines() do
		-- replace the current day with an underlined version
		if offset == 0 then
			line = string.gsub(line, day, string.format(" <b><u>%2d</u></b> ", os.date("%d")))
		end
		caltext = caltext .. "\n" .. line
	end
	fcal:close()

	calobj = naughty.notify({
		title = string.format(
			'<span font_desc="%s"><b>%s</b></span>',
			"monospace",
			os.date("%a, %d %B %Y")
		),
		text = string.format(
			'<span font_desc="%s">%s</span>',
			"monospace",
			caltext
		),
		timeout = 10,
		hover_timeout = 0.5,
		width = 150,
		screen = mouse.screen,
	})
end

-- Function to add the calendar to a given widget
function add(widget)
	widget:add_signal("mouse::enter", function()
		show(0)
	end)
	widget:add_signal("mouse::leave", remove)
	widget:buttons(awful.util.table.join(
		awful.button({}, 4, function()
			show(-1)
		end),
		awful.button({}, 5, function()
			show(1)
		end)
	))
end
