RegisterServerEvent('EveryoneTeleportEntity')
AddEventHandler('EveryoneTeleportEntity', function(ent,x,y,z) 
nent = NetworkGetEntityFromNetworkId(ent)
--print("EveryoneTeleportEntity",ent,nent)

TriggerClientEvent('EveryoneTeleportEntity',-1,ent,x,y,z)
end)


RegisterCommand('visible', function(source, args, rawCommand)
    local _source = source
    local ace = IsPlayerAceAllowed(_source, "vorp.staff.AdminActions")
	if ace then
		TriggerClientEvent('perry_teleport:nakymaton', _source, target_id, time)
	end
end)

RegisterCommand('noclip', function(source, args, rawCommand)
    local _source = source
	
    local ace = IsPlayerAceAllowed(_source, "vorp.staff.AdminActions")
	if ace then
		TriggerClientEvent('Perry_Noclip:noclip', _source)
	else 
		print("Et oo admin")
	end
	
end)

--[[
RegisterCommand('revivee', function(source, args, rawCommand)
	target = args[1]
	TriggerClientEvent('vorp:resurrectPlayer', target) -- heal target
end)]]

VORP = exports.vorp_inventory:vorp_inventoryApi()

local data = {}

Citizen.CreateThread(function()
    data = exports.vorp_inventory:vorp_inventoryApi()
end) 

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterNetEvent("redm:paycheck")
AddEventHandler("redm:paycheck",function()
	local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter
	local job = Character.job
	if job == "unemployed" or job == "intiaani" or job == "gunsmith" or job == "saluuna" then
		Character.addCurrency(0, 10)
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = "+10$"  }) 
	end
	if job == "police" then
        Character.addCurrency(0, 15)
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = "+15$"  }) 
	end
	if job == "medic" then
        Character.addCurrency(0, 15)
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = "+15$"  }) 
	end
end)
