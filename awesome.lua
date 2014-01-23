-- Real config starts here.
-- Lua libraries
posix = require "posix"

-- Standard awesome libraries.
awful = require "awful"
awful.autofocus = require "awful.autofocus"
awful.rules = require "awful.rules"
awful.util = require "awful.util"
--client = require "client"
wibox = require "wibox"

-- Notification library
naughty = require "naughty"

-- Widget library
vicious = require "vicious"

-- Theme library and initialisation
beautiful = require "beautiful"

-- Load settings
require "settings"

debugfile("Loading awesome.lua")

beautiful.init(settings.theme or "/usr/share/awesome/themes/default/theme.lua")
if settings.wallpaper and posix.stat(settings.wallpaper).type == "regular" then
	awful.util.spawn(("awsetbg -f %s"):format(settings.wallpaper))
end

-- Custom modules. Order is important
require "const"
require "autostart"
require "outline"
require "menu"
require "widgets"
require "keys"
require "rules"
require "signals"

-- Order not so important here.
require "mediakeys"
