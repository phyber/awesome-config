-- Rules
local awful = require "awful"
local beautiful = require "beautiful"
local keys = require "keys"

module("rules")

awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {
		},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = true,
			keys = keys.clientkeys,
			buttons = keys.clientbuttons,
		},
	},
	-- Make a few programs floaty
	{
		rule = {
			class = "MPlayer"
		},
		properties = {
			floating = true
		},
	},
	{
		rule = {
			class = "pinentry"
		},
		properties = {
			floating = true
		},
	},
	{
		rule = {
			class = "gimp"
		},
		properties = {
			floating = true
		},
	},
}
