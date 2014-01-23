-- Fail safe, taken from github.com/bioe007

awful = require "awful"
naughty = require "naughty"
io = require "io"
os = require "os"

-- Function we can call from any module to help see what's broken
function perror(s)
	naughty.notify({
		text = s,
		timeout = 0,
	})
end

function debugfile(s)
	local f = io.open(os.getenv("HOME").."/.awesome.debugfile","a+")
	if f then
		f:write(os.date()..": "..s.."\n")
		f:close()
	else
		perror("Couldn't open debugfile")
	end
end

debugfile("New awesome startup...")
local confdir = awful.util.getdir("config")
local rc, err = loadfile(confdir .. "/awesome.lua")
if rc then
	rc, err = pcall(rc)
	if rc then
		return
	end
end

debugfile("Config failed. Loading default.")
-- Loading our config failed, load the default!
dofile("/etc/xdg/awesome/rc.lua")

-- Notify us about the errors.
for s = 1, screen.count() do
	mypromptbox[s].text = awful.util.escape(err:match("[^\n]*"))
end

perror(string.format(
	"Awesome failed to start on %s.\nError: %s",
	os.date("%d/%m/%Y %T"),
	err
))
