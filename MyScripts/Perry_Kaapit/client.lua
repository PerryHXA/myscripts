local VORPutils = {}

TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("Perry_Kaapit:AvaaKaappi")
AddEventHandler("Perry_Kaapit:AvaaKaappi", function(job)
	local id = job
	TriggerServerEvent("Perry_kaapit:Reloadkaapit", id)
	TriggerEvent("vorp_inventory:OpenContainerInventory", id, id, 500)
end)


Citizen.CreateThread(function()
	local PromptGroup = VORPutils.Prompts:SetupPromptGroup() --Setup Prompt Group
	
	local firstprompt = PromptGroup:RegisterPrompt("Paina", 0x8AAA0AD4, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"}) --Register your first prompt
    while true do
        Wait(5)
		local player_coords = GetEntityCoords(PlayerPedId(), true)
		local dist = GetDistanceBetweenCoords(player_coords, vector3(2717.35, -1280.05, 49.53), true) 
		if dist < 1.0 then
			PromptGroup:ShowGroup("Kaappi") --Show your prompt group 
			if firstprompt:HasCompleted() then
				ESX.TriggerServerCallback('Oku_Accounts:HaeTiedotJob', function(tiedot)
					if tiedot.grade == 3 and tiedot.job == "gunsmith" then
						TriggerEvent("Perry_Kaapit:AvaaKaappi", "gunsmith")
					end
				end)
			end
		end
	end
end)

Citizen.CreateThread(function()
	local PromptGroup2 = VORPutils.Prompts:SetupPromptGroup() --Setup Prompt Group
	
	local firstprompt2 = PromptGroup2:RegisterPrompt("Paina", 0x8AAA0AD4, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"}) --Register your first prompt
    while true do
        Wait(5)
		local player_coords = GetEntityCoords(PlayerPedId(), true)
		local dist = GetDistanceBetweenCoords(player_coords, vector3(1328.6, -1325.17, 77.79), true)
		if dist < 1.0 then
			PromptGroup2:ShowGroup("Kaappi") --Show your prompt group 
			if firstprompt2:HasCompleted() then
				ESX.TriggerServerCallback('Oku_Accounts:HaeTiedotJob', function(tiedot)
					if tiedot.grade == 3 and tiedot.job == "rguns" then
						TriggerEvent("Perry_Kaapit:AvaaKaappi", "rguns")
					end
				end)
			end
		end
	end
end)