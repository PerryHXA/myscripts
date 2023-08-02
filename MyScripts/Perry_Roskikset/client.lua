local searched = {3423423424}
local canSearch = true
local dumpsters = {50927092}
local searchTime = 14000

local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


RegisterNetEvent("Perry_Roskis:Tutki")
AddEventHandler("Perry_Roskis:Tutki", function(dumpster)
    if canSearch then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dumpsterFound = false
        for i = 1, #searched do
            if searched[i] == dumpster then
                dumpsterFound = true
            end
            if i == #searched and dumpsterFound then
				TriggerEvent('vorp:ShowBottomRight', "Tämä roskakori on tyhjä!", 4000) 
            elseif i == #searched and not dumpsterFound then
				startSearching(searchTime, 'script_story@mob3@ig@ig1_dutch_holds_up_cashier', 'ig1_cashier_idle_01_cashier', 'Perry_Roskikset:rewarditem')
				TriggerServerEvent('Perry_Roskikset:startdumpsterTimer', dumpster)
				table.insert(searched, dumpster)
				Citizen.Wait(1000)
            end
        end
    end
end)

RegisterNetEvent('Perry_Roskikset:removedumpster')
AddEventHandler('Perry_Roskikset:removedumpster', function(object)
    for i = 1, #searched do
        if searched[i] == object then
            table.remove(searched, i)
        end
    end
end)

function startSearching(time, dict, anim, cb)
    local animDict = dict
    local animation = anim
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()


    canSearch = false

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(0)
    end
        TaskPlayAnim(playerPed, animDict, animation, 8.0, -8.0, time, 0, 0, true, 0, false, 0, false) 
    FreezeEntityPosition(playerPed, true)

	local randomizer =  math.random(2700,4000)
    local testplayer = exports["syn_minigame"]:taskBar(randomizer,7)
    if testplayer == 100 then 
        TriggerServerEvent(cb)
    end

    Wait(2500)
    ClearPedTasks(ped)
    FreezeEntityPosition(playerPed, false)
    canSearch = true
end