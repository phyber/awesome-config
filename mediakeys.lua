-- Bind keyboard media keys.
local pairs	= _G.pairs

-- Awesome modules
local awful	= _G.awful
local root	= _G.root

-- Our modules
local keys	= _G.keys
local settings	= _G.settings

-- Bind the media keys we set in the settings.
local newkeys = {}
for key, cmd in pairs(settings.mediakeys) do
	newkeys = awful.util.table.join(newkeys,
		awful.key({}, key, function()
			awful.util.spawn(cmd, false)
		end)
	)
end

-- Join the new keys into the global keys and set them on the root
keys.globalkeys = awful.util.table.join(keys.globalkeys, newkeys)
root.keys(keys.globalkeys)
