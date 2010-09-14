-- Real config starts here.
-- Lua libraries
require "posix"

-- Standard awesome libraries.
require "awful"
require "awful.autofocus"
require "awful.rules"
require "awful.util"

-- Load settings
require "settings"

-- Theme library and initialisation
require "beautiful"
beautiful.init(settings.theme or "/usr/share/awesome/themes/default/theme.lua")
if settings.wallpaper and posix.stat(settings.wallpaper).type == "regular" then
	awful.util.spawn(string.format("awsetbg -f %s", settings.wallpaper))
end

-- Notification library
require "naughty"

-- Widget library
require "vicious"

-- Custom modules. Order is important
require "autostart"
require "outline"
require "menu"
require "widgets"
require "keys"
require "rules"
require "signals"

-- Order not so important here.
require "mediakeys"
