-- Dropdown terminal
-- Awesome modules
local awful = _G.awful
local keys = _G.keys
local mouse = _G.mouse
local root = _G.root

-- Scratch
local scratch = require "scratch"

-- Add the new keys to the list
local modkey = _G.settings.modkey
keys.globalkeys = awful.util.table.join(keys.globalkeys,
	awful.key({ modkey }, "`", function()
		scratch.drop("uxterm")
	end)
)

-- Set all of the root keys again.
root.keys(keys.globalkeys)
