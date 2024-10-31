GLOBAL.setmetatable(GLOBAL.getfenv(1), {__index = function(self, index)
	return GLOBAL.rawget(GLOBAL, index)
end})-- ty penguin

local unpack = unpack or table.unpack or GLOBAL.unpack

local function results(data, ...)
	return type(data) == "function" and {data(...)}  
		or type(data) == "table" and data 
		or {data} 
end 

local function sandwich(func, ante, post)	
	return function(...)
		local results_ante = results(ante, ...)
		if #results_ante > 0 then return unpack(results_ante) end 		
		
		local results_original = results(func, ...)
		
		local results_post = results(post, ...)
		if #results_post > 0 then return unpack(results_post) end 
		
		return unpack(results_original)
	end 
end 

local function overwrite(tabula, name, ante, post, ifnil)
	if type(tabula) ~= "table" then return end 
	local old = tabula[name]
	if old == nil and ifnil ~= nil then old = ifnil end 
	tabula[name] = sandwich(old, ante, post)
end 

if not GLOBAL.TheNet:GetIsMasterSimulation() then return end

if GetModConfigData("Kraken") then
	AddPrefabPostInit("kraken", function(inst)
		if TheWorld:HasTag"cave" then return end 
		inst:ListenForEvent('death', function(inst)
		
			TheWorld:PushEvent"resetruins"
	
			for _, player in ipairs(AllPlayers) do
				player.components.talker:Say(GetString(player, "ANNOUNCE_RUINS_RESET"))
				player:ShakeCamera(CAMERASHAKE.SIDE, 2, .06, .25)
			end
		end)
	end)
end

if GetModConfigData("Dragonfly") then
	AddPrefabPostInit("dragonfly", function(inst)
		if TheWorld:HasTag"cave" then return end 
		inst:ListenForEvent('death', function(inst)
		
			TheWorld:PushEvent"resetruins"
	
			for _, player in ipairs(AllPlayers) do
				player.components.talker:Say(GetString(player, "ANNOUNCE_RUINS_RESET"))
				player:ShakeCamera(CAMERASHAKE.SIDE, 2, .06, .25)
			end
		end)
	end)
end