-- Real config starts here.

-- Standard awesome libraries.
require "awful"
require "awful.autofocus"
require "awful.rules"

-- Theme library and initialisation
require "beautiful"
beautiful.init("/usr/share/awesome/themes/default/theme.lua")
awful.util.spawn(string.format("awsetbg -f %s/.wallpaper/battlecry-dual-1680x1050.jpg", os.getenv("HOME")))

-- Notification library
require "naughty"

-- Custom modules
require "layouts"
require "menu"
require "widgets"
require "keys"
require "rules"
