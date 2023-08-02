ESX	= nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

local prompts = GetRandomIntInRange(0, 0xffffff)
local prompts2 = GetRandomIntInRange(0, 0xffffff)



Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = Config.Press
	avaaRautio = PromptRegisterBegin()
	PromptSetControlAction(avaaRautio,  Config.keys.G) 
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(avaaRautio, str)
	PromptSetEnabled(avaaRautio, 1)
	PromptSetVisible(avaaRautio, 1)
	PromptSetStandardMode(avaaRautio,1)
    PromptSetHoldMode(avaaRautio, 1)
	PromptSetGroup(avaaRautio, prompts2)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,avaaRautio,true)
	PromptRegisterEnd(avaaRautio)
end)


TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

RegisterNetEvent('Perry_Juna:AvaileppasMenua')
AddEventHandler('Perry_Juna:AvaileppasMenua', function()

	Junat()

end)



local ratikka = -1083616881

function Ratikat()
	SetNuiFocus(false)
	local elements = {
		{label = 'Raitiovaunu | 50$',    value = 'ratikka', price = 50}
	}
	MenuData.Open(

		'default', GetCurrentResourceName(), 'ratikat_talli',

		{

			title    = 'Rautiovaunut',

			subtext    = 'Vuokraa rautiovaunuja',

			align    = 'top-left',

			elements = elements,

		},

		function(data, menu)
		local price = data.current.price
		local juna = data.current.value
		if data.current.value == 'ratikka' then
			menu.close()
			TriggerServerEvent('Perry_Juna:MaksaRatikasta', price, ratikka)
		end
	end, function(data, menu)
		menu.close()
	end) 
end

local hash1 = 987516329
local hash2 = 0x515E31ED
local hash3 = 0x487B2BE7
local hash4 = 0x8EAC625C
local hash5 = 0xF9B038FC
local hash6 = 0x005E03AD
local hash7 = 0x3260CE89
local hash8 = 0x3D72571D
local hash9 = 0x5AA369CA
local hash10 = 0x0660E567
local hash11 = 0x0392C83A

function Junat()
	SetNuiFocus(false)
	local elements = {
		{label = 'Matkustajajuna | 50$',    value = 'hash1', price = 50}, 
		{label = 'Vankilakuljetus | 50$',    value = 'hash2', price = 50}, 
		{label = 'Talvi | 50$',    value = 'hash3', price = 50}, 
		{label = 'Kuljetus | 50$',    value = 'hash4', price = 50}, 
		{label = 'Palkkionmetsästäjä | 50$',    value = 'hash5', price = 50}, 
		{label = 'Iso juna | 50$',    value = 'hash6', price = 50}, 
		{label = 'Veturi | 50$',    value = 'hash7', price = 50}, 
		{label = 'Hybridi | 50$',    value = 'hash8', price = 50}, 
		{label = 'Hybridi2 | 50$',    value = 'hash9', price = 50}, 
		{label = 'Teollisuus | 50$',    value = 'hash10', price = 50}, 
		{label = 'Iso juna 2 | 50$',    value = 'hash11', price = 50}
	}
	MenuData.Open(

		'default', GetCurrentResourceName(), 'boss_venetalli',

		{

			title    = 'Junatalli',

			subtext    = 'Vuokraa junia',

			align    = 'top-left',

			elements = elements,

		},

		function(data, menu)
		local price = data.current.price
		local juna = data.current.value
		if data.current.value == 'hash1' then
			menu.close()
			TriggerServerEvent('Perry_Juna:MaksaJunasta', price, hash1)
		elseif data.current.value == 'hash2' then
			menu.close()
			TriggerServerEvent('Perry_Juna:MaksaJunasta', price, hash1)
		elseif data.current.value == 'hash2' then
			menu.close()
			TriggerServerEvent('Perry_Juna:MaksaJunasta', price, hash1)
		elseif data.current.value == 'hash3' then
			menu.close()
			TriggerServerEvent('Perry_Juna:MaksaJunasta', price, hash1)
		elseif data.current.value == 'hash4' then
			menu.close()
			TriggerServerEvent('Perry_Juna:MaksaJunasta', price, hash1)
		elseif data.current.value == 'hash5' then
			menu.close()
			TriggerServerEvent('Perry_Juna:MaksaJunasta', price, hash1)
		elseif data.current.value == 'hash6' then
			menu.close()
			TriggerServerEvent('Perry_Juna:MaksaJunasta', price, hash1)
		elseif data.current.value == 'hash7' then
			menu.close()
			TriggerServerEvent('Perry_Juna:MaksaJunasta', price, hash1)
		elseif data.current.value == 'hash8' then
			menu.close()
			TriggerServerEvent('Perry_Juna:MaksaJunasta', price, hash1)
		elseif data.current.value == 'hash9' then
			menu.close()
			TriggerServerEvent('Perry_Juna:MaksaJunasta', price, hash1)
		elseif data.current.value == 'hash10' then
			menu.close()
			TriggerServerEvent('Perry_Juna:MaksaJunasta', price, hash1)
		elseif data.current.value == 'hash11' then
			menu.close()
			TriggerServerEvent('Perry_Juna:MaksaJunasta', price, hash1)
		end
	end, function(data, menu)
		menu.close()
	end) 
end

RegisterNetEvent('Perry_Juna:Spawnaaratikka')
AddEventHandler('Perry_Juna:Spawnaaratikka', function(hash)
	StartTrain2(hash)
end)

RegisterNetEvent('Perry_Juna:Spawnaajuna')
AddEventHandler('Perry_Juna:Spawnaajuna', function(hash)
	--print("vittumeniclient")
	--print(hash)
	StartTrain(hash)
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.NpcLocations) do
		RequestModel(GetHashKey("A_M_M_BLWObeseMen_01"))
		while not HasModelLoaded( GetHashKey("A_M_M_BLWObeseMen_01") ) do
            Citizen.Wait(100)
        end
		if HasModelLoaded(GetHashKey("A_M_M_BLWObeseMen_01")) then
			NpcPed = CreatePed(GetHashKey("A_M_M_BLWObeseMen_01"),  v.x, v.y, v.z-1.2, v.h, false, false, 0, 0)
			Citizen.InvokeNative(0x283978A15512B2FE, NpcPed, true)
			FreezeEntityPosition(NpcPed, true)
			SetEntityInvincible(NpcPed, true)
			SetBlockingOfNonTemporaryEvents(NpcPed, true)
			SetModelAsNoLongerNeeded(GetHashKey("A_M_M_BLWObeseMen_01"))
			modeltodelete = NpcPed
		end
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.NpcLocations) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.x, v.y, v.z)
        SetBlipSprite(blip, 1202244626, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Junatalli")
    end
end)

function deletepedit()
	local entity = modeltodelete
    NetworkRequestControlOfEntity(entity)
    local timeout = 2000
    while timeout > 0 and not NetworkHasControlOfEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end
    SetEntityAsMissionEntity(entity, true, true)
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
    
    if (DoesEntityExist(entity)) then 
		DeletePed(entity)
		modeltodelete = nil
	end
	modeltodelete = nil
end

AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  deletepedit()
end)

local trainspawned = 0
local ratikatspawned = 0

function StartTrain2(hash)

	if ratikatspawned <= 3 then
		--print(ratikatspawned)
		SetRandomTrains(false)
		--requestmodel--
		local trainWagons = N_0x635423d55ca84fc8(hash)
		for wagonIndex = 0, trainWagons - 1 do
			local trainWagonModel = N_0x8df5f6a19f99f0d5(hash, wagonIndex)
			while not HasModelLoaded(trainWagonModel) do
				Citizen.InvokeNative(0xFA28FE3A6246FC30, trainWagonModel, 1)
				Citizen.Wait(100)
			end
		end
		--spawn train--
		local train = N_0xc239dbd9a57d2a71(hash, GetEntityCoords(PlayerPedId()), 0, 1, 1, 1)
		SetTrainSpeed(train, 0.0)
		TaskWarpPedIntoVehicle(PlayerPedId(), train, -1)
		SetModelAsNoLongerNeeded(train)
		--blip--
		local blipname = "Rautiovaunu"
		local bliphash = -399496385
		local blip = Citizen.InvokeNative(0x23f74c2fda6e7c61, bliphash, train) -- BLIPADDFORENTITY
		SetBlipScale(blip, 1.5)
		CURRENT_TRAIN = train
		ratikatspawned = ratikatspawned + 1
		--print(ratikatspawned)
		ratikatrunninng = true
		Citizen.Wait(5000)
		while ratikatrunninng do
			Citizen.Wait(60000)
			if not IsPedInAnyTrain(PlayerPedId()) then
				DeleteEntity(CURRENT_TRAIN)
				ratikatspawned = ratikatspawned - 1
				ratikatrunninng = false
			end
		end
	else
		TriggerEvent("vorp:TipRight", "Rautiovaunuja on liikaa, tarkista kartta!", 3000)
	end
end

RegisterCommand("juna", function(source, args, rawCommand)
	StartTrain(987516329)
end)

--[[
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local coords = GetEntityCoords(PlayerPedId())
		local paska = Citizen.InvokeNative(0x86AFC343CF7F0B34, GetHashKey("FREIGHT_GROUP"), coords.x, coords.y, coords.z) -- BLIPADDFORENTITY
		if IsControlJustPressed(0, 0xDEB34313) then
			print("oikealle")
			Citizen.InvokeNative(0xE6C5E2125EB210C1, trackki, paska, 1) -- BLIPADDFORENTITY
		end
		if IsControlJustPressed(0, 0xA65EBAB4) then
			print("vasuri")
			Citizen.InvokeNative(0xE6C5E2125EB210C1, trackki, paska, 2) -- BLIPADDFORENTITY
		end
	end
end)

--]]

function StartTrain(hash)

	if trainspawned <= 3 then
		--print(trainspawned)
		SetRandomTrains(false)
		--requestmodel--
		local trainWagons = N_0x635423d55ca84fc8(hash)
		for wagonIndex = 0, trainWagons - 1 do
			local trainWagonModel = N_0x8df5f6a19f99f0d5(hash, wagonIndex)
			while not HasModelLoaded(trainWagonModel) do
				Citizen.InvokeNative(0xFA28FE3A6246FC30, trainWagonModel, 1)
				Citizen.Wait(100)
			end
		end
		--spawn train--
		local train = N_0xc239dbd9a57d2a71(hash, GetEntityCoords(PlayerPedId()), 0, 1, 1, 1)
		SetTrainSpeed(train, 0.0)
		TaskWarpPedIntoVehicle(PlayerPedId(), train, -1)
		SetModelAsNoLongerNeeded(train)
		--blip--
		local blipname = "Juna"
		local bliphash = -399496385
		local blip = Citizen.InvokeNative(0x23f74c2fda6e7c61, bliphash, train) -- BLIPADDFORENTITY
		SetBlipScale(blip, 1.5)
		CURRENT_TRAIN = train
		trainspawned = trainspawned + 1
		--print(trainspawned)
		trainrunning = true
		Citizen.Wait(5000)
		while trainrunning do
			Citizen.Wait(60000)
			if not IsPedInAnyTrain(PlayerPedId()) then
				DeleteEntity(CURRENT_TRAIN)
				trainspawned = trainspawned - 1
				trainrunning = false
			end
		end
	else
		TriggerEvent("vorp:TipRight", "Junia on liikaa, tarkista kartta!", 3000)
	end
end

RegisterCommand('deletetrain', function()
	DeleteEntity(CURRENT_TRAIN)
	trainspawned = trainspawned - 1
	--print(trainspawned)
	trainrunning = false
end)

RegisterCommand('deleteratikka', function()
	DeleteEntity(CURRENT_TRAIN)
	trainspawned = trainspawned - 1
	--print(trainspawned)
	trainrunning = false
end)

