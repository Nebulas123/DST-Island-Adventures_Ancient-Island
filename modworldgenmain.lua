GLOBAL.setmetatable(GLOBAL.getfenv(1), {__index = function(self, index)
	return GLOBAL.rawget(GLOBAL, index)
end})-- ty penguin

-- Import dependencies.
package.loaded["librarymanager"] = nil
local AutoSubscribeAndEnableWorkshopMods = require("librarymanager")
if IsWorkshopMod(modname) then
    AutoSubscribeAndEnableWorkshopMods({"workshop-1467214795"})
else  --if the Gitlab Versions dont exist fallback on workshop version
    AutoSubscribeAndEnableWorkshopMods({KnownModIndex:GetModActualName(" Island Adventures - GitLab Ver.") or "workshop-1467214795"})
end

local Layouts, Get = require"map/layouts".Layouts, require"map/static_layout".Get
for name, centered in pairs{
	monkey_guarded_altar = true, 
	ag_centered = true, 
} do 
	Layouts[name] = Get(
		"map/static_layouts/" .. name, 
		centered and {
			layout_position = LAYOUT_POSITION.CENTER, 
			start_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
		} or nil
	) 
end 

require"map/terrain"
--GLOBAL.terrain.filter.moonglass_rock = GLOBAL.terrain.filter.rock_moon
for key in pairs(GLOBAL.terrain.filter) do 
	if key ~= "Print" then 
		GLOBAL.terrain.filter[key] = nil 
	end 
end -- death to you stupid filters

AddRoom("ancient_island_altar", {colour={r=.8,g=0.5,b=.6,a=.50},
	value = WORLD_TILES.MUD,
	tags = {}, 
	contents = {
		countstaticlayouts = {monkey_guarded_altar = 1}, 
		distributepercent = 1, 
		distributeprefabs = {
			fireflies = 0.1,
			blue_mushroom = 0.02,
			grass = .05,
			sapling = .5,
			flower_cave = 0.4,
			flower_cave_double = 0.3,
			flower_cave_triple = 0.2,
		}, 
		countprefabs = {
			batcave = 2, 
			
			ruins_statue_mage_spawner = 1, 
			ruins_statue_mage_nogem_spawner = 2,
			ruins_statue_head_spawner = 1, 
			ruins_statue_head_nogem_spawner = 2, 
			
			cave_banana_tree = 1, 
			flower_cave_double = 1,
			flower_cave_triple = 1,
		}, 
	}
})

AddRoom("ancient_island_barracks", {colour={r=.8,g=0.5,b=.6,a=.50},
	value = WORLD_TILES.MUD,
	tags = {}, 
	contents = {
		countstaticlayouts = {Barracks2 = 1}, 
		distributepercent = 1, 
		distributeprefabs = {
			fireflies = 0.1,
			blue_mushroom = 0.02,
			grass = .05,
			sapling=.5,
			flower_cave = 0.3,
			flower_cave_double = 0.2,
			flower_cave_triple = 0.1,
		}, 
		countprefabs = {
			dropperweb = 2, 
			archive_centipede = 1, 
			
			ruins_statue_mage_spawner = 1, 
			ruins_statue_mage_nogem_spawner = 2,
			ruins_statue_head_spawner = 1, 
			ruins_statue_head_nogem_spawner = 2, 
			
			monkeybarrel_spawner = 1, 
			cave_banana_tree = 1, 
			flower_cave = 1,
			flower_cave_double = 1,
		}, 
	}
})

AddRoom("ancient_island_bg", {colour={r=.8,g=0.5,b=.6,a=.50},
	value = WORLD_TILES.MUD,
	tags = {}, 
	contents = {
		distributepercent = 1, 
		distributeprefabs = {
			fireflies = 0.1,
			blue_mushroom = 0.02,
			grass = .05,
			sapling=.5,
			flower_cave = 0.3,
			flower_cave_double = 0.2,
			flower_cave_triple = 0.2,
		}, 
		countprefabs = {
			ruins_statue_mage_spawner = 2, 
			ruins_statue_mage_nogem_spawner = 4,
			ruins_statue_head_spawner = 2, 
			ruins_statue_head_nogem_spawner = 4, 
			monkeybarrel_spawner = 2, 
			dropperweb = 2, 
			cave_banana_tree = 3, 
			
			slurper_spawner = 1, 
			chessjunk_spawner = 3, 
			cave_hole = 2, 

			flower_cave = 1,
			flower_cave_double = 1,
		}, 
	}
})

AddTask("ancient_island", {colour={r=0.6,g=0.6,b=0.0,a=1},
	region_id = "ancient_island",  
	locks = LOCKS.ISLAND2,
    keys_given = {KEYS.ISLAND3},
	room_bg = WORLD_TILES.MUD, 
	level_set_piece_blocker = true,
	
	room_tags = {
		"RoadPoison", 
		"not_mainland", 
		"nohunt"
	}, 
	background_room = "BGImpassable", 
	room_choices = {
		ancient_island_bg = (SIZE_VARIATION > 3) and 2 or 1, 
		ancient_island_barracks = 1, 
		ancient_island_altar = 1, 
	}, 
	
	cove_room_name = "Empty_Cove",
	cove_room_chance = 1,
	cove_room_max_edges = 2,
})

AddTaskSetPreInit("shipwrecked", function(task_set)
	table.insert(task_set.tasks, "ancient_island")
end)