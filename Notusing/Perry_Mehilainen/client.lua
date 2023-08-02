ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local etsitty = {3423423424}
local canSearch = true
local nestit = {1407324434}
local searchTime = 14000

RegisterNetEvent('Perry_Mehilainen:Testataan')
AddEventHandler('Perry_Mehilainen:Testataan', function(object)
	ESX.TriggerServerCallback('Perry_Mehilainen:EtsiPurkki', function(HasPurkki)
		if HasPurkki then
			if canSearch then
				local ped = PlayerPedId()
				local pos = GetEntityCoords(ped)
				local nestfound = false

				for i = 1, #nestit do
					local dumpster = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, nestit[i], false, false, false)
					local dumpPos = GetEntityCoords(dumpster)
					local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, dumpPos.x, dumpPos.y, dumpPos.z, true)
					local playerPed = PlayerPedId()


					if dist < 1.8 then
						for i = 1, #etsitty do
							if etsitty[i] == dumpster then
								nestfound = true
							end
							if i == #etsitty and nestfound then
								TriggerEvent("vorp:TipRight", "Tämä ampiaispesä on tyhjä", 4000) -- from client side
							elseif i == #etsitty and not nestfound then
								startSearching(searchTime, 'script_story@mob3@ig@ig1_dutch_holds_up_cashier', 'ig1_cashier_idle_01_cashier', 'Perry_Mehilainen:rewarditem')
								TriggerServerEvent('Perry_Mehilainen:startdumpsterTimer', dumpster)
								table.insert(etsitty, dumpster)
								Citizen.Wait(1000)
							end
						end  
					end
				end
			end
		else
			TriggerEvent("vorp:TipRight", "Sinulla ei ole purkkia", 4000) -- from client side
		end
	end)
end)

RegisterNetEvent('Perry_Mehilainen:removedumpster')
AddEventHandler('Perry_Mehilainen:removedumpster', function(object)
    for i = 1, #etsitty do
        if etsitty[i] == object then
            table.remove(etsitty, i)
        end
    end
end)

-- Functions

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
 --   QBCore.Functions.Progressbar("reful_boat", "Searching The dumpster..", 14000)
	local player = PlayerPedId()
    local coords = GetEntityCoords(player) 
	local prop = CreateObject(GetHashKey("p_vg_jar03x"), coords.x, coords.y, coords.z, 1, 0, 1)
	Citizen.InvokeNative(0x6B9BBD38AB0796DF, prop,player,GetEntityBoneIndexByName(player,"SKEL_R_Finger12"), 0.02, 0.028, 0.001, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
    TaskPlayAnim(playerPed, animDict, animation, 8.0, -8.0, time, 0, 0, true, 0, false, 0, false) 
    FreezeEntityPosition(playerPed, true)

	local randomizer =  math.random(2700,4000)
    local testplayer = exports["syn_minigame"]:taskBar(randomizer,7)
    if testplayer == 100 then 
        TriggerServerEvent(cb)
    end

    Wait(5000)
	DeleteEntity(prop)
    ClearPedTasks(ped)
    FreezeEntityPosition(playerPed, false)
    canSearch = true
end

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())  
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    if onScreen then
    	SetTextScale(0.30, 0.30)
  		SetTextFontForCurrentCommand(1)
    	SetTextColor(255, 255, 255, 215)
    	SetTextCentre(1)
    	DisplayText(str,_x,_y)
    	local factor = (string.len(text)) / 225
    	DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
    	--DrawSprite("feeds", "toast_bg", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
    end
end
