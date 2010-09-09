-- Real config starts here.

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
if settings.wallpaper then
	awful.util.spawn(string.format("awsetbg -f %s", settings.wallpaper))
end

-- Notification library
require "naughty"

-- Widget library
require "vicious"

-- Custom modules. Order is important
require "outline"
require "menu"
require "widgets"
require "keys"
require "rules"
require "signals"
