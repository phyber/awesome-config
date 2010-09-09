-- Fail safe, taken from github.com/bioe007

require "awful"
require "naughty"

-- Function we can call from any module to help see what's broken
function naughty_error(s)
	naughty.notify({
		text = s,
		timeout = 0,
	})
end

local confdir = awful.util.getdir("config")
local rc, err = loadfile(confdir .. "/awesome.lua")
if rc then
	rc, err = pcall(rc)
	if rc then
		return
	end
end

-- Loading our config failed, load the default!
dofile("/etc/xdg/awesome/rc.lua")

-- Notify us about the errors.
for s = 1, screen.count() do
	mypromptbox[s].text = awful.util.escape(err:match("[^\n]*"))
end

--[[
naughty.notify({
	text = string.format(
		"Awesome failed to start on %s. Error: %s\n",
		os.date("%d/%m/%Y %T"),
		err
	),
	timeout = 0
})]]
naughty_error(string.format(
	"Awesome failed to start on %s.\nError: %s",
	os.date("%d/%m/%Y %T"),
	err
))
