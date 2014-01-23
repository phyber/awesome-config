-- Real config starts here.
-- Lua libraries
posix = require "posix"

-- Standard awesome libraries.
awful = require "awful"
awful.autofocus = require "awful.autofocus"
awful.rules = require "awful.rules"
awful.util = require "awful.util"

-- Load settings
require "settings"

-- Theme library and initialisation
beautiful = require "beautiful"

debugfile("Loading awesome.lua")

beautiful.init(settings.theme or "/usr/share/awesome/themes/default/theme.lua")
if settings.wallpaper and posix.stat(settings.wallpaper).type == "regular" then
	awful.util.spawn(string.format("awsetbg -f %s", settings.wallpaper))
end

-- Notification library
require "naughty"

-- Widget library
vicious = require "vicious"

-- Custom modules. Order is important
require "autostart"
require "outline"
require "menu"
wibox = require "wibox"
require "widgets"
require "keys"
require "rules"
require "signals"

-- Order not so important here.
require "mediakeys"
