local wanted_region_is_activated = false
local wanted_region_hash = 0
local map_color = 0
Citizen.CreateThread(function()
	for k,v in pairs(Config.Map) do
		wanted_region_hash = v.hash -- REGION_BLU_SISIKA
		map_color = v.color
		Citizen.InvokeNative(0x563FCB6620523917, wanted_region_hash, GetHashKey(map_color));
		wanted_region_is_activated = true
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k,v in pairs(Config.Map) do
			wanted_region_hash = v.hash -- REGION_BLU_SISIKA
        	Citizen.InvokeNative(0x6786D7AFAC3162B3, wanted_region_hash);
        	wanted_region_is_activated = false
		end
	end
end)