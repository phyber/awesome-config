-- Widgets

local awful = _G.awful
local screen = _G.screen
local vicious = _G.vicious
local widget = _G.widget
local outline = _G.outline

module("widgets")

local modkey = "Mod4"

-- Network Usage
network = widget({ type = "textbox" })
vicious.register(
	network,
	vicious.widgets.net,
	'<span color="#CC9393">${br0 down_kb}</span> <span color="#7F9F7F">${br0 up_kb}</span>',
	1
)

-- CPU Usage
cpu = widget({ type = "textbox" })
vicious.register(
	cpu,
	vicious.widgets.cpu,
	' $1% ',
	1
)

-- ALSA Volume Widget
volume = widget({ type = "textbox" })
vicious.register(
	volume,
	vicious.widgets.volume,
	' $2$1% ',
	0.5,
	'Master'
)
-- Volume clicking
-- 1 = Left click
-- 2 = Right click
-- 4 = Mouse wheel up
-- 5 = Mouse wheel down
volume:buttons(awful.util.table.join(
	awful.button({}, 1, function() awful.util.spawn("amixer -q sset Master toggle", false) end),
	awful.button({"Shift"}, 1, function() awful.util.spawn("xterm -e alsamixer", true) end),
	awful.button({}, 4, function() awful.util.spawn("amixer -q sset Master 5%+", false) end),
	awful.button({}, 5, function() awful.util.spawn("amixer -q sset Master 5%-", false) end)
))

-- Text clock
textclock = awful.widget.textclock(
	{ align = "right" },
	"%a %b %d, %H:%M:%S ",
	1
)

-- CALENDAR HERE

-- Systray
systray = widget({ type = "systray" })

-- Create and fill the wibox
wibox = {}
promptbox = {}
layoutbox = {}
taglist = {}
taglist.buttons = awful.util.table.join(
	awful.button({}, 1, awful.tag.viewonly),
	awful.button({ modkey }, 1, awful.client.movetotag),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, awful.client.toggletag),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
)

tasklist = {}
tasklist.buttons = awful.util.table.join(
	awful.button({}, 1, function(c)
		if not c:isvisible() then
			awful.tag.viewonly(c:tags()[1])
		end
		client.focus = c
		c:raise()
	end),
	awful.button({}, 3, function()
		if instance then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients({ width = 250 })
		end
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
		if client.focus then
			client.focus:raise()
		end
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
		if client.focus then
			client.focus:raise()
		end
	end)
)

-- Add these things to each screen.
for s = 1, screen.count() do
	-- Prompt box
	promptbox[s] = awful.widget.prompt({
		layout = awful.widget.layout.horizontal.leftright
	})
	-- Layout box
	layoutbox[s] = awful.widget.layoutbox(s)
	layoutbox[s]:buttons(awful.util.table.join(
		awful.button({}, 1, function () awful.layout.inc(outline.layouts, 1) end),
		awful.button({}, 3, function () awful.layout.inc(outline.layouts, -1) end),
		awful.button({}, 4, function () awful.layout.inc(outline.layouts, 1) end),
		awful.button({}, 5, function () awful.layout.inc(outline.layouts, -1) end)
	))
	-- Taglist
	taglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, taglist.buttons)
	-- Tasklist
	tasklist[s] = awful.widget.tasklist(function(s) return awful.widget.fasklist.label.currenttags(c, s) end, tasklist.buttons)
	-- Wibox
	wibox[s] = awful.wibox({
		position = "top",
		screen = s
	})
	-- Add widgets to the box. Order matters
	wibox[s].widgets = {
		{
			launcher,
			taglist[s],
			promptbox[s],
			layout = awful.widget.layout.horizontal.leftright,
		},
		layoutbox[s],
		textclock,
		volume,
		network,
		cpu,
		-- Systray only on first monitor
		s == 1 and systray or nil,
		tasklist[s],
		layout = awful.widget.layout.horizontal.rightleft,
	}
end
