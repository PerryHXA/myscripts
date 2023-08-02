local prop 
local has = true
local onperkele = true

RegisterNetEvent("Perry_Reput:PoistaReppu")
AddEventHandler("Perry_Reput:PoistaReppu",function()
	DeleteObject(prop)
end)

--[[
RegisterCommand('poistareppu', function()
  TriggerEvent("Perry_Reput:PoistaReppu")
end)]]

RegisterNetEvent('Perry_Reput:plaguemaskit') -- Näppäimistö
AddEventHandler('Perry_Reput:plaguemaskit', function(maski)	
	local playerPed = PlayerPedId()

    RequestAnimDict("mech_inventory@clothing@bandana")
    while not HasAnimDictLoaded("mech_inventory@clothing@bandana") do
        Citizen.Wait(100)
    end
	TaskPlayAnim(playerPed, "mech_inventory@clothing@bandana", "NECK_2_FACE_RH", 8.0, 8.0, 12600, 0, 0, true, 0, false, 0, false)
	Citizen.Wait(2000)
	if onperkele then 
		onperkele = false
		local prop_name = maski
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
		AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 43676), 0.0, 0.03, -0.01, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
	else
		onperkele = true
		DeleteObject(prop)
	end
end)

RegisterNetEvent('Perry_Reput:native') -- Näppäimistö
AddEventHandler('Perry_Reput:native', function(maski)	
	local playerPed = PlayerPedId()

    RequestAnimDict("mech_inventory@clothing@bandana")
    while not HasAnimDictLoaded("mech_inventory@clothing@bandana") do
        Citizen.Wait(100)
    end
	TaskPlayAnim(playerPed, "mech_inventory@clothing@bandana", "NECK_2_FACE_RH", 8.0, 8.0, 12600, 0, 0, true, 0, false, 0, false)
	Citizen.Wait(2000)
	if onperkele then 
		onperkele = false
		local prop_name = maski
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
		AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 43676), 0.0, 0.03, -0.01, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
	else
		onperkele = true
		DeleteObject(prop)
	end
end)

RegisterNetEvent('Perry_Reput:reppu1') -- Näppäimistö
AddEventHandler('Perry_Reput:reppu1', function()	
	print(has)
	if has then 
		has = false
		local prop_name = 'p_ambpack01x'
		local playerPed = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
		AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 16496), 0.05, 0.05, -0.15, 180.0, 90.0, -30.0, true, true, false, true, 1, true)
	else
		has = true
		DeleteObject(prop)
	end
end)

RegisterNetEvent('Perry_Reput:reppu2') -- Näppäimistö
AddEventHandler('Perry_Reput:reppu2', function()	
	if has then 
		has = false
		local prop_name = 'p_ambpack02x'
		local playerPed = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
		AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 16496), -0.15, 0.10, -0.20, 180.0, 90.0, -30.0, true, true, false, true, 1, true)	
	else
		has = true
		DeleteObject(prop)
	end
end)

RegisterNetEvent('Perry_Reput:reppu3') -- Näppäimistö
AddEventHandler('Perry_Reput:reppu3', function()	
	if has then 
		has = false
		local prop_name = 'p_ambpack04x'
		local playerPed = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		DeleteObject(prop)
		prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
		AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 16496), -0.30, -0.05, -0.25, -80.0, 90.0, -30.0, true, true, false, true, 1, true)
	else
		has = true
		DeleteObject(prop)
	end
end)

RegisterNetEvent("jimbo_badge:putOn")
AddEventHandler("jimbo_badge:putOn", function()
    local ped = PlayerPedId()
    if IsPedMale(ped) then
        --male
        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x1FC12C9C, true, true, true)
        Citizen.Wait(1)
        --print("male equipped")
    else
        --female
        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, 0x929677D, true, true, true)
        Citizen.Wait(1)
        --print("female equipped")
    end 
end)

RegisterNetEvent("jimbo_badge:takeOff")
AddEventHandler("jimbo_badge:takeOff", function()
    local ped = PlayerPedId()
    if IsPedMale(ped) then
        --male
        Citizen.InvokeNative(0x0D7FFA1B2F69ED82, ped, 0x1FC12C9C, 0, 0)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, false)
        Citizen.Wait(1)
        --print("male removed")
    else
        --female
        Citizen.InvokeNative(0x0D7FFA1B2F69ED82, ped, 0x929677D, 0, 0)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, false)
        Citizen.Wait(1)
        --print("female removed")
    end 
end)

RegisterCommand("tunnuspois", function()
    local ped = PlayerPedId()
    TriggerEvent("jimbo_badge:takeOff", ped)
end)