local notpressed = false
local canChange = true
local lastPreView
local pressTime = 0
local pressLeft = 0

local recentlySpawned = 0

local kuumisModel;
local kuumisSpawn = {}
local NumberkuumisSpawn = 0

ESX	= nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

local VORPutils = {}

TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)

local kuumis = {
	[1] = {
		['Text'] = "[$2200] Kuumailmapallo",
		['Text2'] = "[$100] Kuumailmapallo (Vuokraus)",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Price'] = 2200,
			['Vuokra'] = 100,
			['Model'] = "hotAirBalloon01"
		}
	}

}

Citizen.CreateThread(function()
	for i,v in pairs(Config.Kuumakaupat) do
		LoadModel(v.modeli)
		NpcPed = CreatePed(v.modeli, v.npc, v.npch, false, true, true, true)
		Citizen.InvokeNative(0x283978A15512B2FE, NpcPed, true)
		FreezeEntityPosition(NpcPed, true)
		SetEntityInvincible(NpcPed, true)
		SetBlockingOfNonTemporaryEvents(NpcPed, true)
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	DeleteEntity(NpcPed)
	SetEntityAsNoLongerNeeded(NpcPed)	
end)

local KuumisLista = {}
for k,v in pairs(kuumis) do

    table.insert(KuumisLista, {label = v["Text"], value = k , desc =  "Parasta laatua jo vuodesta 1899", })
end

local KuumisLista2 = {}
for k,v in pairs(kuumis) do

    table.insert(KuumisLista2, {label = v["Text2"], value = k , desc =  "Parasta laatua jo vuodesta 1899", })
end

Citizen.CreateThread(function()
	local  avaaKuumis = VORPutils.Prompts:SetupPromptGroup() --Setup Prompt Group
	
	local avaakuumis = avaaKuumis:RegisterPrompt("Paina", 0x8AAA0AD4, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"}) --Register your first prompt
	while true do
		sleep = 2000
		for i,v in pairs(Config.Kuumakaupat) do
			local player_coords = GetEntityCoords(PlayerPedId(), true)
			local dist = GetDistanceBetweenCoords(player_coords, v.ostovalikko, true)
			if dist < 1.0 then
				sleep = 1
				avaaKuumis:ShowGroup("Kuumailmapallo")
				if avaakuumis:HasCompleted() then
					KMenu(v.pallo)
				end
			end
		end
		Wait(sleep)
	end
end)

function KMenu(pallo)
	
	local elements = {
			{label = "Osta kuumailmapallo", value = 'osta'},
			{label = "Vuokraa kuumailmapallo", value = 'vuokraa'},
			{label = "Talli", value = 'talli'}
	}
	MenuData.Open(

		'default', GetCurrentResourceName(), 'kuumismenu_menu',

		{

			title    = 'Kuumailmapallot',

			subtext    = 'Osta/Vuokraa kuumailmapalloja',

			align    = 'top-left',

			elements = elements,

		},

		function(data, menu)
		
		local category = data.current.value

		if category == 'osta' then
			menu.close()
			local playercoords = GetEntityCoords(PlayerPedId())
			if canChange == true then
				canChange = false
				PreView (kuumis[1].Param.Model)
				canChange = true
			end


			MenuData.Open('default', GetCurrentResourceName(), 'kuumapallo_menu',

				{

					title    = 'Kuumailmapallo Kauppias',

					subtext    = 'Osta veneitä',

					align    = 'top-left',

					elements = KuumisLista,

				},

				function(data, menu)

					menu.close()
					TriggerServerEvent('Perry_Kuumailmapallo:OstaKuumis', kuumis[data.current.value]['Param'])
					if lastPreView ~= nil then
						DeleteEntity(lastPreView)
						while DoesEntityExist(lastPreView) do
							Wait(0)
						end
					end

				end,

				function(data, menu)

					menu.close()
					DestroyAllCams(true)
					if lastPreView ~= nil then
						DeleteEntity(lastPreView)
						while DoesEntityExist(lastPreView) do
							Wait(0)
						end
					end
				end,


				function(data, menu)
					if canChange == true then
						canChange = false
						PreView (kuumis[data.current.value].Param.Model, pallo)
						canChange = true
					end
				end


			)
		elseif category == 'vuokraa' then
			menu.close()
			local playercoords = GetEntityCoords(PlayerPedId())
			if canChange == true then
				canChange = false
				PreView (kuumis[1].Param.Model)
				canChange = true
			end


			MenuData.Open('default', GetCurrentResourceName(), 'kuumapallo_menu',

				{

					title    = 'Kuumailmapallo Kauppias',

					subtext    = 'Osta veneitä',

					align    = 'top-left',

					elements = KuumisLista2,

				},

				function(data, menu)

					menu.close()
					TriggerServerEvent('Perry_Kuumailmapallo:Vuokraakuumis', kuumis[data.current.value]['Param'])
					if lastPreView ~= nil then
						DeleteEntity(lastPreView)
						while DoesEntityExist(lastPreView) do
							Wait(0)
						end
					end

				end,

				function(data, menu)

					menu.close()
					DestroyAllCams(true)
					if lastPreView ~= nil then
						DeleteEntity(lastPreView)
						while DoesEntityExist(lastPreView) do
							Wait(0)
						end
					end
				end,


				function(data, menu)
					if canChange == true then
						canChange = false
						PreView (kuumis[data.current.value].Param.Model, pallo)
						canChange = true
					end
				end


			)
		elseif category == 'talli' then
			menu.close()
			TalliMenu()
		end
	end, function(data, menu)
		menu.close()
	end) 
end
TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

function LoadModel(model)
    local model = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
    end
end

function TalliMenu()
	ESX.TriggerServerCallback('Perry_Kuumapallo:HaePallot', function(pallot)
        local elements = {}

        for k, v in pairs(pallot) do 
            table.insert(elements, { label = v['kuumis'], value = "otapallo" })
        end

        if ( #elements == 0 ) then
            table.insert(elements, { label = 'Tyhjä!',})
        end
		
		MenuData.Open(

			'default', GetCurrentResourceName(), 'kuumis_talli',

			{

				title    = 'Ilmapallo talli',

				subtext    = 'OTA KUUMAILMAPALLOJA',

				align    = 'top-left',

				elements = elements,

			},

			function(data, menu)
			
			local category = data.current.value
			local pallo = data.current.label
			
			if category == 'otapallo' then
				menu.close()
				TriggerEvent('Perry_Kuumailmapallo:SpawnaaPallo', pallo)
			end
		end, function(data, menu)
			menu.close()
		end) 
	end)
end

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

RegisterNetEvent( 'Perry_Kuumailmapallo:SpawnaaPallo' )
AddEventHandler( 'Perry_Kuumailmapallo:SpawnaaPallo', function ( kuumis )

	local player = PlayerPedId()

	local model = GetHashKey( kuumis )
	local x,y,z = table.unpack( GetOffsetFromEntityInWorldCoords( player, 0.0, 4.0, 0.5 ) )

	local heading = GetEntityHeading( player ) + 90

	local oldIdOfThekuumis = idOfThekuumis
	
	local idOfThekuumis = NumberkuumisSpawn + 1

	RequestModel( model )

	while not HasModelLoaded( model ) do
		Wait(500)
	end

	if ( kuumisSpawn[idOfThekuumis] ~= oldIdOfThekuumis ) then
		DeleteEntity( kuumisSpawn[idOfThekuumis].model )
	end

	kuumisModel = CreateVehicle( model, 2562.14, -823.3, 42.26, heading, 1, 1 )

	SET_PED_DEFAULT_OUTFIT (kuumisModel)
	Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, kuumisModel)
	
	kuumisSpawn[idOfThekuumis] = { id = idOfThekuumis, model = kuumisModel }

end )


function SET_PED_DEFAULT_OUTFIT ( kuumis )
	return Citizen.InvokeNative(0xAF35D0D2583051B0, kuumis, true )
end

Citizen.CreateThread(function()
	for i,v in pairs(Config.Kuumakaupat) do
		local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.ostovalikko)
		SetBlipSprite(blip, -924533810, 1)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Kuumailmapallokauppa")
	end
end)

-- | Timer | --


local hidden = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local wait = 500
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsUsing(playerPed)
        local driving = GetPedInVehicleSeat(vehicle, -1)

        if IsPedInFlyingVehicle(playerPed) and driving then	
			if IsDisabledControlJustPressed(0, 0x8CC9CD42) then
				if not hidden then
					ESX.Notify(5, 'Saat ohjeet näkyviin painamalla [X] uudelleen')
					hidden = true
				else
					hidden = false
				end
			end	
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped)
            local model = GetEntityModel(veh)
            if model == 1588640480 then
				if not hidden then
					DrawTxt('~h~Kuumailmapallo~h~ ~n~~n~~n~Liiku: [WASD]~n~Nouse: [Shift]~n~Sulje ohjeet: [X]', 0.13, 0.16, 0.5, 0.5, true, 255, 0, 0, 200, true)
				end

                local y = GetControlNormal(2, 0x8FD015D8)
				local s = GetControlNormal(2, 0xD27782E3)
                local left = GetControlNormal(2, 0x7065027D) 
                local right = GetControlNormal(2, 0xB4E465B4) 

                if y > 0.01 then
                    SetVehicleForwardSpeed(veh, y * 4) 
                end
				if s > 0.01 then
                    SetVehicleForwardSpeed(veh, y - 1) 
                end
                heading = GetEntityHeading(veh)
                local set = false
                if left > 0.01 then
                    heading = heading + left

                    if heading >= 360.0 then
                        heading = 0
                    end
                    set = true
                end

                if right > 0.01 then
                    heading = heading - right
                    if heading <= 0.0 then
                        heading = 359.99
                    end
                    set = true
                end

                if set then
                SetEntityHeading(veh, heading) 
                end
            end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
		if recentlySpawned > 0 then
			recentlySpawned = recentlySpawned - 1
		end
    end
end)

function PreView (model, pallo)
	local _model = GetHashKey( model )
    while not HasModelLoaded( _model ) do
        Wait(1)
        modelrequest( _model )
    end
    if lastPreView ~= nil then
        DeleteEntity(lastPreView)
        while DoesEntityExist(lastPreView) do
            Wait(1)
        end
    end
	lastPreView = CreateVehicle( _model, pallo, 1, 1 )
    while not DoesEntityExist(lastPreView) do
        Wait(1)
    end
    SetEntityAsMissionEntity(lastPreView, true, true)
    FreezeEntityPosition(lastPreView , true)
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(0.4, 0.4)
    --SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(true)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
    local factor = (string.len(str)) / 60
    DrawSprite("menu_textures", "translate_bg_1a", x, y+0.120,0.015+ factor, 0.30, 0.1, 2, 2, 2, 200, 0)
end