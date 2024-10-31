local function en_zh(en, zh)  -- Other languages don't work
    return (locale == "zh" or locale == "zhr" or locale == "zht") and zh or en
end

-- Mod Name
name = en_zh("Island Adventures - Ancient Island", "岛屿冒险 - 远古岛")

-- Mod Authors
author = "NebulaKKK"

-- Mod Version
version = "1.0.1"

-- Mod Description
description = en_zh(
	"Add ancient island in Island Adventures.Killing quacken or dragonfly will reset the statues.",
	"在海难中添加远古岛屿,击败海妖或龙蝇可以刷新雕像"
)

description = description .. "\n\nVersion: " .. version

-- In-game link to a thread or file download on the Klei Entertainment Forums
forumthread = "/topic/95080-island-adventures-the-shipwrecked-port/"

IslandAdventures = true

folder_name = folder_name or "workshop-"
if not folder_name:find("workshop-") then
	name = " " .. name .. " - Local Ver."
	description = description .. "\n\nRemember to manually update!"
	IslandAdventuresGitlab = true
end

-- Don't Starve API version
-- Note: We set this to 10 so that it's incompatible with single player.
api_version = 10
-- Don't Starve Together API version
api_version_dst = 10

-- Priority of which our mod will be loaded
-- Below 0 means other mods will override our mod by default.
-- Above 0 means our mod will override other mods by default.
priority = 1 --loads after IA (2) but before generic mods

-- Forces user to reboot game upon enabling the mod
restart_required = false

-- Engine/DLC Compatibility
-- Don't Starve (Vanilla, no DLCs)
dont_starve_compatible = false
-- Don't Starve: Reign of Giants
reign_of_giants_compatible = false
-- Don't Starve: Shipwrecked
shipwrecked_compatible = false
-- Don't Starve Together
dst_compatible = true

-- Client-only mods don't affect other players or the server.
client_only_mod = false
-- Mods which add new objects are required by all clients.
all_clients_require_mod = true

-- Server search tags for the mod.
server_filter_tags =
{
	"Island Adventures",
	"Essential Islands",
}

-- Preview image
icon_atlas = "ia-icon.xml"
icon = "ia-icon.tex"

mod_dependencies = {
    {    -- Island Adventures
        workshop = "workshop-1467214795",
        ["IslandAdventures"] = false,
        ["Island Adventures - GitLab Ver."] = true
    },
}

-- Thanks to the Gorge Extender by CunningFox for making me aware of this being possible -M
local function Breaker(title_en, title_zh)  --hover does not work, as this item cannot be hovered
	return {name = en_zh(title_en, title_zh) , options = {{description = "", data = false}}, default = false}
end

local options_enable = {
	{description = en_zh("Disabled", "关闭"), data = false},
	{description = en_zh("Enabled", "开启"), data = true},
}

configuration_options =
{
	Breaker("Reset Option", "重置选项"),
	{
		name = "Kraken",
		label = en_zh("Quacken", "海妖"),
        hover = en_zh("Kill quacken to reset the statues", "击败海妖重置远古"),
        options = options_enable,
	},
	{
		name = "Dragonfly",
		label = en_zh("Dragonfly", "龙蝇"),
        hover = en_zh("Kill dragonfly to reset the statues", "击败龙蝇重置远古"),
        options = options_enable,
	},
}

-- Add default settings for options, don't have to rewrite same every time
for i = 1, #configuration_options do
	configuration_options[i].options = configuration_options[i].options or options_enable
	configuration_options[i].default = configuration_options[i].default == nil and true or configuration_options[i].default
end

