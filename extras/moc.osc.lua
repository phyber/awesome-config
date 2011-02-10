#!/usr/bin/env lua
--[[
-- To use this, simply use the OnSongChange feature in ~/.moc/config
-- OnSongChange = "/home/user/.moc/moc.osc.lua %a %r %t %n %f %D %d"
-- Change the string.format()s below to change the look of the notifications.
--]]
-- Track info
local ti = {
	artist	= arg[1],
	album	= arg[2],
	title	= arg[3],
	track	= arg[4],
	filename= arg[5],
	dursec	= arg[6],
	durmin	= arg[7],
}

local ac = io.popen("awesome-client", "w")
if ac then
	local notification = string.format(
		'naughty.notify({title = "%s", text = "%s", timeout = 10, screen = 1,})\n',
		-- Artist: Album is the title of the notification
		string.format('%s: %s', ti.artist, ti.album),
		-- Track info for the rest of it.
		string.format('Track %02d: %s\\nDuration: %s', ti.track, ti.title, ti.durmin)
	)
	ac:write(notification)
	ac:close()
end
