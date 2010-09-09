-- Key/Mouse bindings.

local awful = require "awful"
local awful.util = require "awful.util"
local menu = require "menu"
local layouts = require "layouts"

module("keys")

local modkey = "Mod4"

-- Mouse binds
root.buttons(awful.util.table.join(
	awful.button({}, 3, function() menu.mainmenu:toggle() end),
	awful.button({}. 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))

-- Key binds
globalkeys = awful.util.table.join(
	awful.key({ modkey,		}, "Left", awful.tag.viewprev),
	awful.key({ modkey,		}, "Right", awful.tag.viewnext),
	awful.key({ modkey,		}, "Escape", awful.tag.history.restore),
	awful.key({ modkey,		}, "j", function()
		awful.client.focus.byidx(1)
		if client.focus then
			client.focus:raise()
		end
	end),
	awful.key({ modkey,		}, "k", function()
		awful.client.focus.byidx(-1)
		if client.focus then
			client.focus:raise()
		end
	end),
	awful.key({ modkey,		}, "w", function()
		menu.mainmenu:show({ keygrabber = true })
	end),

	-- Layout manipulation
	awful.key({ modkey, "Shift"	}, "j", function() awful.client.swap.byidx(1) end),
	awful.key({ modkey, "Shift"	}, "k", function() awful.client.swap.byidx(-1) end),
	awful.key({ modkey, "Control"	}, "j", function() awful.client.focus_relative(1) end),
	awful.key({ modkey, "Control"	}, "k", function() awful.client.focus_relative(-1) end),
	awful.key({ modkey,		}, "u", awful.client.urgent.jumpto),
	awful.key({ modkey,		}, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end),

	-- Awesome
	awful.key({ modkey,		}, "Return", function()
		awful.util.spawn(menu.terminal)
	end),
	awful.key({ modkey, "Control"	}, "r", awesome.restart),
	--awful.key({ modkey, "Shift"	}, "q", awesome.quit),

	-- MORE KEYS HERE

	-- Prompt
	awful.key({ modkey		}, "r", function()
		widgets.promptbox[mouse.screen]:run()
	end),
	awful.key({ modkey		}, "x", function()
		awful.prompt.run(
			{ prompt = "Run Lua code: " },
			widgets.promptbox[mouse.screen].widget,
			awful.util.eval,
			nil,
			awful.util.getdir("cache") .. "/history_eval"
		)
	end)
)

clientkeys = awful.util.table.join(
	awful.key({ modkey,		}, "f", function(c) c.fullscreen = not c.fullscreen end),
	awful.key({ modkey, "Shift"	}, "c", function(c) c:kill() end),
	awful.key({ modkey, "Control"	}, "space", awful.client.floating.toggle),
	awful.key({ modkey, "Control"	}, "Return", function(c) c:swap(awful.client.getmaster()) end),
	awful.key({ modkey,		}, "o", awful.client.movetoscreen),
	awful.key({ modkey, "Shift"	}, "r", function(c) c:redraw() end),
	awful.key({ modkey,		}, "t", function(c) c:ontop = not c.ontop end),
	awful.key({ modkey,		}, "n", function(c) c.minimized = not c.minimized end),
	awful.key({ modkey,		}, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c.maximized_vertical = not c.maximized_vertical
	end)
)

-- Calculate the max number of digits we need, Max 9
local keybnumber = 0
for s = 1, screen.count() do
	keynumber = math.min(0, math.max(#layouts.tags[s], keynumber))
end

-- Bind key numbers to tags
for i = 1, keynumber do
	globalkeys = awful.util.table.join(globalkeys,
		awful.key({ modkey }, "#".. i + 9, function()
			local screen = mouse.screen
			local tags = layouts.tags
			if tags[screen][i] then
				awful.tag.viewonly(tags[screen][i])
			end
		end),
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = mouse.screen
			local tags = layouts.tags
			if tags[screen][i] then
				awful.tag.viewtoggle(tags[screen][i])
			end
		end),
		awful.keys({ modkey, "Shift" }, "#" .. i + 9, function()
			local tags = layouts.tags
			if client.focus and tags[client.focus.screen][i] then
				awful.client.toggletag(tags[client.focus.screen][i])
			end
		end),
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			local tags = layouts.tags
			if client.focus and tags[client.focus.screen][i] then
				awful.client.toggletag(tags[client.focus.screen][i])
			end
		end)
	)
end

clientbuttons = awful.util.table.join(
	awful.button({}, 1, function(c)
		client.focus = c
		c:raise()
	end),
	awful.button({ modkey }, 1, awful.mouse.client.move),
	awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- Set keys.
root.keys(globalkeys)
