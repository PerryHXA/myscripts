local NearNpc, CurrentNpc = false, nil

Citizen.CreateThread(function()
	SpawnNpcs()
end)

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

--[[
RegisterCommand('minecart', function(source, args, rawCommand)
    Citizen.CreateThread(function()
        local trainHash = -950361972 -- minecart
        print(trainHash)
        local trainWagons = N_0x635423d55ca84fc8(trainHash)
        print(trainWagons)
        for wagonIndex = 0, trainWagons - 1 do
            local trainWagonModel = N_0x8df5f6a19f99f0d5(trainHash, wagonIndex)
            LoadModel(trainWagonModel)
        end
        local train = N_0xc239dbd9a57d2a71(trainHash, GetEntityCoords(PlayerPedId()), 0, 0, 1, 1)
        print(train)
        SetTrainSpeed(train, 0.0)
        --TaskWarpPedIntoVehicle(PlayerPedId(), train, -1)
    end)
end)]]

function LoadModel(model)
    local attempts = 0
    while attempts < 1000 and not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(1)
        attempts = attempts + 1
    end
    return IsModelValid(model)
end

function SpawnNpcs()
    for k, v in pairs(Config.PedInteraction) do
		RequestModel(GetHashKey(v['Model']))
		while not HasModelLoaded( GetHashKey(v['Model']) ) do
            Citizen.Wait(100)
        end
		if HasModelLoaded(GetHashKey(v['Model'])) then
			NpcPed = CreatePed(GetHashKey(v['Model']),  v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'], v['Coords']['H'], false, false, 0, 0)
			Citizen.InvokeNative(0x283978A15512B2FE, NpcPed, true)
			FreezeEntityPosition(NpcPed, true)
			SetEntityInvincible(NpcPed, true)
			SetBlockingOfNonTemporaryEvents(NpcPed, true)
			SetModelAsNoLongerNeeded(GetHashKey(v['Model']))
			if v['Animation'] ~= nil then
				TaskStartScenarioInPlace(NpcPed, v['Animation'], 0, true)
			end
			v['CurrentPedNumber'] = NpcPed
		end
    end
end

AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  DespawnNpcs()
end)

function DespawnNpcs()
    for k, v in pairs(Config.PedInteraction) do
        DeletePed(v['CurrentPedNumber'])
    end
end

local myInput = {
    type = "enableinput", -- don't touch
    inputType = "input", -- input type
    button = "Hyväksy", -- button name
    placeholder = "Määrä", -- placeholder name
    style = "block", -- don't touch
    attributes = {
        inputHeader = "Kuinka monta haluat myydä?", -- header
        type = "number", -- inputype text, number,date,textarea ETC
        pattern = "[0-9]", --  only numbers "[0-9]" | for letters only "[A-Za-z]+" 
        title = "Vain numerot", -- if input doesnt match show this message
        style = "border-radius: 10px; background-color: ; border:none;"-- style 
    }
}

RegisterNetEvent('Perry_NPC:MyyTuotteita')
AddEventHandler('Perry_NPC:MyyTuotteita', function(entity)	---Ensin pitää tehdä menu mistä valitaan mitä myydään
	local elements = {
		{label = 'Pontikka',    value = 'ponu'},
		{label = 'Opium',    value = 'opium'},
		{label = 'Kokaiini',    value = 'koka'}
	}
	MenuData.Open(

		'default', GetCurrentResourceName(), 'boss',

		{

			title    = 'Mitä haluat myydä?',

			subtext    = '',

			align    = 'top-left',

			elements = elements,

		},

		function(data, menu)
		
		if data.current.value == 'takemoney' then
			menu.close()
			TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
				
				if result ~= "" and result then -- make sure its not empty or nil
					print(result) --returns string
				else
					print("it's empty?") --notify
				end
			end)
		elseif data.current.value == 'putmoney' then
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end) 
end)

function OstaaTuotteen(entity)
	FreezeEntityPosition(entity, true)
	ClearPedSecondaryTask(entity)
	Citizen.Wait(2000)
	TaskTurnPedToFaceEntity(entity, PlayerPedId(), 2000)
	Citizen.Wait(2000)
	local objekti = GetHashKey("s_drugpackage_02x")
	TaskTurnPedToFaceEntity(PlayerPedId(), entity, 2000)
	Citizen.Wait(2000)
	--FreezeEntityPosition(entity, true)
	local ped_coords = GetEntityCoords(PlayerPedId())
	local prop = CreateObject(objekti, ped_coords.x, ped_coords.y, ped_coords.z + 0.2, true, true, false, false, true)
	local boneIndex = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_R_Finger12")
	AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.04, 0.018, 0.10, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
    RequestAnimDict('script_common@other@unapproved')
    while not HasAnimDictLoaded('script_common@other@unapproved') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_common@other@unapproved', 'loop_0', 1.0, -1.0, 400, 30, 0, true, 0, false, 0, false)
    RequestAnimDict('mech_inspection@two_fold_map@satchel')
    while not HasAnimDictLoaded('mech_inspection@two_fold_map@satchel') do
        Citizen.Wait(100)
    end
	Citizen.Wait(500)
	DeleteEntity(prop)
	TaskPlayAnim(entity, "mech_inspection@two_fold_map@satchel", "exit_satchel", 1.0, -1.0, 2000, 30, 0.4, true, 0, false, 0, false)
	local ped_coords2 = GetEntityCoords(entity)
	Citizen.Wait(500)
	local prop2 = CreateObject(objekti, ped_coords.x, ped_coords.y, ped_coords.z + 0.2, true, true, false, false, true)
	local boneIndex2 = GetEntityBoneIndexByName(entity, "SKEL_R_Finger12")
	AttachEntityToEntity(prop2, entity, boneIndex2, 0.04, 0.018, 0.10, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
	Citizen.Wait(1000)
	FreezeEntityPosition(entity, false)
	DeleteEntity(prop2)
end


