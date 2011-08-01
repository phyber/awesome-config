#!/usr/bin/env lua
local os = require "os"

-- Track info
local ti = {}
for i = 1, #arg, 2 do
	ti[arg[i]] = arg[i + 1]
end

-- We only want to display things if the status is playing.
if ti.status ~= "playing" then
	os.exit()
end

local escapes = {
	['&'] = '&amp;',
	['<'] = '&lt;',
	['>'] = '&gt;',
}

local function escape(s)
	if not s then
		return s
	end
	for old, new in pairs(escapes) do
		s = s:gsub(old, new)
	end
	return s
end

local function duration(secs)
	return string.format("%02d:%02d", secs / 60, secs % 60)
end

local ac = io.popen("awesome-client", "w")
if ac then
	local notification = string.format(
		'naughty.notify({title = "%s", text = "%s", timeout = 10, screen = 1,})\n',
		-- 'Artist: Album' is the title of the notification
		string.format('%s: %s', escape(ti.artist), escape(ti.album)),
		-- Track info for the rest of it.
		string.format('Track %02d: %s\\nDuration: %s', escape(ti.tracknumber), escape(ti.title), escape(duration(ti.duration)))
	)
	ac:write(notification)
	ac:close()
end
