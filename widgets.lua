-- Widgets
-- Awesome modules
local awful	= _G.awful
local beautiful	= _G.beautiful
local screen	= _G.screen
local vicious	= _G.vicious
local wibox	= _G.wibox
local client	= _G.client

-- Our modules
local const	= _G.const
local menu	= _G.menu
local outline	= _G.outline
local settings	= _G.settings
local calendar	= require "calendar"
local debugfile = _G.debugfile

debugfile("Loading widgets.lua")
module("widgets")

local modkey = settings.modkey

-- Launcher
debugfile("Launcher...")
launcher = awful.widget.launcher({
	image = beautiful.awesome_icon,
	menu = menu.mainmenu
})

-- Network Usage
debugfile("Network...")
network = wibox.widget.textbox()
vicious.register(
	network,
	vicious.widgets.net,
	('<span color="#CC9393">${%s down_kb}</span> <span color="#7F9F7F">${%s up_kb}</span>'):format(settings.netif, settings.netif),
	1
)

-- CPU Usage
debugfile("CPU...")
cpu = wibox.widget.textbox()
vicious.register(
	cpu,
	vicious.widgets.cpu,
	'$1%',
	1
)

-- ALSA Volume Widget
local volume = true
if volume then
	debugfile("Volume...")
	volume = wibox.widget.textbox()
	debugfile("Volume register...")
	vicious.register(
		volume,
		vicious.widgets.volume,
		'$2$1%',
		0.5,
		'Master'
	)
	-- Volume clicking
	-- 1 = Left click
	-- 2 = Right click
	-- 4 = Mouse wheel up
	-- 5 = Mouse wheel down
	debugfile("Volume buttons...")
	volume:buttons(awful.util.table.join(
		awful.button({}, const.MOUSE_LEFT_BTN, function()
			awful.util.spawn("amixer -q sset Master toggle", false)
		end),
		awful.button({"Shift"}, const.MOUSE_MIDDLE_BTN, function()
			awful.util.spawn("urxvt -e alsamixer", true)
		end),
		awful.button({}, const.MOUSE_WHEEL_UP, function()
			awful.util.spawn("amixer -q sset Master 1dB+", false)
		end),
		awful.button({}, const.MOUSE_WHEEL_DN, function()
			awful.util.spawn("amixer -q sset Master 1dB-", false)
		end)
	))
end

-- Text clock
debugfile("Clock...")
textclock = awful.widget.textclock(
	"%a %b %d, %H:%M:%S",
	1
)
-- Shift clicking the clock will lock the screen
textclock:buttons(awful.util.table.join(
	awful.button({ "Shift" }, const.MOUSE_LEFT_BTN, function()
		awful.util.spawn(settings.lockscreen, false)
	end)
))
-- Attach a calendar if module is loaded.
if calendar then
	debugfile("Attaching calendar to clock...")
	calendar.add(textclock)
end

-- Spacer/Separator
spacer = wibox.widget.textbox()
spacer:set_text(" ")
separator = wibox.widget.textbox()
separator:set_markup("<tt>|</tt>")

-- Systray
debugfile("Systray...")
systray = wibox.widget.systray()

-- Create and fill the wibox
debugfile("Wibox...")
_wibox = {}
_promptbox = {}
_layoutbox = {}
_taglist = {}
_taglist.buttons = awful.util.table.join(
	awful.button({}, const.MOUSE_LEFT_BTN, awful.tag.viewonly),
	awful.button({ modkey }, const.MOUSE_LEFT_BTN, awful.client.movetotag),
	awful.button({}, const.MOUSE_RIGHT_BTN, awful.tag.viewtoggle),
	awful.button({ modkey }, const.MOUSE_RIGHT_BTN, awful.client.toggletag),
	awful.button({}, const.MOUSE_WHEEL_UP, awful.tag.viewnext),
	awful.button({}, const.MOUSE_WHEEL_DN, awful.tag.viewprev)
)

debugfile("Tasklist...")
_tasklist = {}
_tasklist.buttons = awful.util.table.join(
	awful.button({}, const.MOUSE_LEFT_BTN, function(c)
		if not c:isvisible() then
			awful.tag.viewonly(c:tags()[1])
		end
		client.focus = c
		c:raise()
	end),
	awful.button({}, const.MOUSE_RIGHT_BTN, function()
		if instance then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients({ width = 250 })
		end
	end),
	awful.button({}, const.MOUSE_WHEEL_UP, function()
		awful.client.focus.byidx(1)
		if client.focus then
			client.focus:raise()
		end
	end),
	awful.button({}, const.MOUSE_WHEEL_DN, function()
		awful.client.focus.byidx(-1)
		if client.focus then
			client.focus:raise()
		end
	end)
)

debugfile("Screenloop...")
-- Add these things to each screen.
for s = 1, screen.count() do
	local left_layout = wibox.layout.fixed.horizontal()
	local right_layout = wibox.layout.fixed.horizontal()
	local layout = wibox.layout.align.horizontal()

	-- Prompt box
	_promptbox[s] = awful.widget.prompt()

	-- Layout box
	_layoutbox[s] = awful.widget.layoutbox(s)
	_layoutbox[s]:buttons(awful.util.table.join(
		awful.button({}, const.MOUSE_LEFT_BTN, function() awful.layout.inc(outline.layouts, 1) end),
		awful.button({}, const.MOUSE_RIGHT_BTN, function() awful.layout.inc(outline.layouts, -1) end),
		awful.button({}, const.MOUSE_WHEEL_UP, function() awful.layout.inc(outline.layouts, 1) end),
		awful.button({}, const.MOUSE_WHEEL_DN, function() awful.layout.inc(outline.layouts, -1) end)
	))

	-- Taglist
	_taglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, _taglist.buttons)

	-- Tasklist
	_tasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, _tasklist.buttons)

	-- Wibox
	_wibox[s] = awful.wibox({
		position = "top",
		screen = s
	})

	-- Systray
	right_layout:add(systray)
	right_layout:add(spacer)
	right_layout:add(separator)
	right_layout:add(spacer)

	-- Layout
	left_layout:add(launcher)
	left_layout:add(_taglist[s])
	left_layout:add(_promptbox[s])

	-- CPU
	right_layout:add(cpu)
	right_layout:add(spacer)
	right_layout:add(separator)
	right_layout:add(spacer)

	-- Network
	right_layout:add(network)
	right_layout:add(spacer)
	right_layout:add(separator)
	right_layout:add(spacer)

	-- Volume
	right_layout:add(volume)
	right_layout:add(spacer)
	right_layout:add(separator)
	right_layout:add(spacer)

	-- Textclock
	right_layout:add(textclock)
	right_layout:add(spacer)
	right_layout:add(separator)
	right_layout:add(spacer)

	-- Layoutbox
	right_layout:add(_layoutbox[s])

	layout:set_left(left_layout)
	layout:set_middle(_tasklist[s])
	layout:set_right(right_layout)

	_wibox[s]:set_widget(layout)
end
