local VorpCore = {}
local VorpInv = {}
local ESX = exports['vorp_core']:GetObj()  --// Saa haettua callbackit toimimaan, voi myös käyttää esx:getSharedobject eventtiä


VorpInv = exports.vorp_inventory:vorp_inventoryApi()

TriggerEvent("getCore",function(core)
    VorpCore = core
end)


RegisterNetEvent('hospital:server:SendToBed', function(bedId, isRevive, dead, price)
	local src = source
	local Player = VorpCore.getUser(src).getUsedCharacter
	TriggerClientEvent('hospital:client:SendToBed', src, bedId, Config.Locations["beds"][bedId], isRevive)
	TriggerClientEvent('hospital:client:SetBed', -1, bedId, true)
	if not dead then
		Player.removeCurrency(0, 10)
	else
		Player.removeCurrency(0, tonumber(price))
		ESX.Notify(src, 5, 'Maksoit päivystävän tohtorin palkkion: '..price..'$')
	end
end)


CreateThread(function()
	while true do
		Wait(5*60000)
		TriggerEvent('hospital:server:SetDoctor')
	end
end)

RegisterNetEvent('hospital:server:SetDoctor', function()
	local amount = 0
    local players = GetPlayers()
    for k,v in pairs(players) do
		local ply = VorpCore.getUser(v).getUsedCharacter
        if ply.job == 'medic' then
            amount = amount + 1
        end
	end
	TriggerClientEvent("hospital:client:SetDoctorCount", -1, amount)
end)

AddEventHandler('playerDropped', function()
	TriggerClientEvent('beds:playerDropped', source)
end)