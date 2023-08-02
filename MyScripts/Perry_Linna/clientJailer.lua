local cJ = false
local IsPlayerUnjailed = false

ESX = nil

MenuData = {}

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
    Citizen.CreateThread(function()
		TriggerServerEvent("Perry_Jail:CheckJail")
    end)
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

AddEventHandler('onClientResourceStart', function (resourceName)
	if(GetCurrentResourceName() == resourceName) then
		TriggerServerEvent("Perry_Jail:CheckJail")
	end
end)

RegisterNetEvent("Perry_Jail:JailInStation")
AddEventHandler("Perry_Jail:JailInStation", function(JailTime)
	jailing(JailTime)
end)

Citizen.CreateThread(function()
    local blip = N_0x554d9d53f696d002(1664425300, 3360.81, -686.19, 45.59)
    SetBlipSprite(blip, 1293773224, 1)
	SetBlipScale(blip, 0.2)
	Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Vankila") 
end)


function jailing(JailTime)
	if cJ == true then
		return
	end
	print(JailTime)
	local PlayerPed = PlayerPedId()
	if DoesEntityExist(PlayerPed) then
		
		Citizen.CreateThread(function()
			local spawnloccoords = {}
			SetEntityCoords(PlayerPed, 3350.55,-684.88, 44.01 )
			cJ = true
			IsPlayerUnjailed = false
			while JailTime > 0 and not IsPlayerUnjailed do
				local remainingjailseconds = JailTime/ 60
				local jailseconds =  math.floor(JailTime) % 60 
				local remainingjailminutes = remainingjailseconds / 60
				local jailminutes =  math.floor(remainingjailseconds) % 60
				local remainingjailhours = remainingjailminutes / 24
				local jailhours =  math.floor(remainingjailminutes) % 24
				local remainingjaildays = remainingjailhours / 365 
				local jaildays =  math.floor(remainingjailhours) % 365

				
				PlayerPed = PlayerPedId()
				if IsPedInAnyVehicle(PlayerPed, false) then
					ClearPedTasksImmediately(PlayerPed)
				end
				if JailTime % 10 == 0 then
					if JailTime % 30 == 0 then
						TriggerEvent('chatMessage', 'SYSTEM', { 0, 0, 0 }, math.floor(jaildays).." päivää, "..math.floor(jailhours).." tuntia,"..math.floor(jailminutes).." minuuttia, "..math.floor(jailseconds).." sekuntia ennen vapauttamista.")
					end
				end
				Citizen.Wait(1000)
				local playerPed = PlayerPedId()
				local coords = GetEntityCoords(playerPed)
				local betweencoords = GetDistanceBetweenCoords(coords, 3350.55,-684.88, 44.01, true)
				if betweencoords > 250.0 then
					DoScreenFadeOut(200)
					Wait(1000)
					SetEntityCoords(PlayerPed, 3350.55,-684.88, 44.01)
					Wait(500)
					DoScreenFadeIn(200)
					TriggerServerEvent('chatMessageEntered', "SYSTEM", { 0, 0, 0 }, "Mihin kuvittelit meneväsi")
				end
				JailTime = JailTime - 1.0
			end
			TriggerServerEvent('chatMessageEntered', "SYSTEM", { 0, 0, 0 }, GetPlayerName(PlayerId()) .." vapautettiin vankilasta.")
			TriggerServerEvent('Perry_Jail:UnJailplayer2')
			local outsidecoords = {}
			outsidecoords = SetPlayerSpawnLocationoutsidejail(Station)
			SetEntityCoords(PlayerPedId(), 2803.12,-1447.48,45.12)
			SetEntityHeading(PlayerPedId(), 45.93)
			cJ = false
		end)
	end
end


RegisterNetEvent("Perry_Jail:LaitaLinnaanKekw")
AddEventHandler("Perry_Jail:LaitaLinnaanKekw", function()
    maxLength = 4
	AddTextEntry('FMMC_MPM_NA', "Syötä tuntimäärä, jonka haluat asettaa henkilön vankilaan:")
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", maxLength)
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait( 0 )
	end

	local jailtime = GetOnscreenKeyboardResult()

	UnblockMenuInput()
	
	Citizen.Wait(500)
	
	local elements = {{label = "Poistu", value = 'exit'}}
	local player, distance = GetClosestPlayer()
	if distance <= 1.5 and distance > 0 then
		table.insert(elements, {label = GetPlayerName(player), value = 'henkilo'})
	end
	MenuData.Open('default', GetCurrentResourceName(), 'give_key',
	{
		title = "Henkilö",
		align = 'top-left',
		elements = elements
	}, function(data2, menu2)
		if data2.current.value == 'henkilo' then
			TriggerServerEvent('Perry_Jail:PutInJail', tonumber(jailtime)*60 *60, GetPlayerServerId(player))
			menu2.close()
		else
			menu2.close()
		end
	end, function(data2, menu2)
		menu2.close()
	end)
end)

RegisterNetEvent("Perry_Jail:UnjailaaLinna")
AddEventHandler("Perry_Jail:UnjailaaLinna", function(target_id)
	local playerid = target_id
	
	TriggerServerEvent('Perry_Jail:UnJailplayer', playerid)
end)

function UnblockMenuInput()
    Citizen.CreateThread( function()
        Citizen.Wait( 150 )
        blockinput = false 
    end )
end

function SetPlayerSpawnLocationjail(location)
	if location == 'FederalJail' then
		return {x=3346.685,y=-689.046,z=44.052, distance = 80}
	end
end

function SetPlayerSpawnLocationoutsidejail(location)
	if location == 'FederalJail' then
		return {x=2485.761,y=-1305.571,z=47.901}
	end
end

RegisterNetEvent("Perry_Jail:UnJail")
AddEventHandler("Perry_Jail:UnJail", function()
	IsPlayerUnjailed = true
	DoScreenFadeOut(500)
	Wait(1000)
	SetEntityCoords(PlayerPedId(), 2803.12,-1447.48,45.12)
	SetEntityHeading(PlayerPedId(), 45.93)
	Wait(500)
	DoScreenFadeIn(500)
end)

function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
    local playerPed, playerId = PlayerPedId(), PlayerId()
    local coords, usePlayerPed = coords, false
    
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end
    
    for i=1, #players, 1 do
        local tgt = GetPlayerPed(players[i])

        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then

            local targetCoords = GetEntityCoords(tgt)
            local distance = #(coords - targetCoords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end


