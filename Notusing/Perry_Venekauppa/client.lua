local notpressed = false
local canChange = true
local lastPreView
local pressTime = 0
local pressLeft = 0

local recentlySpawned = 0

local boatModel;
local boatSpawn = {}
local NumberboatSpawn = 0

ESX	= nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)


local veneet = {

	[1] = {
		['Text'] = Config.Texts.rboat1,
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Name'] = "Swamp Row Boat 2",
			['Price'] = Config.Prices.rboat1,
			['Model'] = "rowboatSwamp02",
		}
	},

	[2] = {
		['Text'] = Config.Texts.rboat2,
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Name'] = "Swamp Row Boat",
			['Price'] = Config.Prices.rboat2,
			['Model'] = "rowboatSwamp",
		}
	},

	[3] = {
		['Text'] = Config.Texts.rboat3,
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Name'] = "Row Boat",
			['Price'] = Config.Prices.rboat3,
			['Model'] = "rowboat",
		}
	},

	[4] = {
		['Text'] = Config.Texts.rboat4,
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Name'] = "Row Boat",
			['Price'] = Config.Prices.rboat4,
			['Model'] = "rowboat",
		}
	},

	[5] = {
		['Text'] = Config.Texts.sboat1,
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Name'] = "Steam Boat",
			['Price'] = Config.Prices.sboat1,
			['Model'] = "KEELBOAT",
		}
	},

	[6] = {
		['Text'] = Config.Texts.sboat2,
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Name'] = "Modern Steam Boat",
			['Price'] = Config.Prices.sboat2,
			['Model'] = "boatsteam02x",
		}
	}
	
}

local VeneLista = {}
for k,v in pairs(veneet) do

    table.insert(VeneLista, {label = v["Text"], value = k , desc =  Config.Texts.description, })
end



RegisterNetEvent('Perry_Venekauppa:Setinsetinsetit')
AddEventHandler('Perry_Venekauppa:Setinsetinsetit', function()

	VeneTalli()

end)

function VeneTalli()
	SetNuiFocus(false)
	local elements = {
		{label = Config.Texts.BuyMenu,    value = 'ostavene'},
		{label = Config.Texts.TakeMenu,    value = 'talli'}
	}
	MenuData.Open(

		'default', GetCurrentResourceName(), 'boss_venetalli',

		{

			title    = Config.Texts.Title,

			subtext    = Config.Texts.SubText,

			align    = 'top-left',

			elements = elements,

		},

		function(data, menu)
		
		if data.current.value == 'ostavene' then
			menu.close()
			VeneMenu()
		elseif data.current.value == 'talli' then
			menu.close()
			TalliMenu()
		end
	end, function(data, menu)
		menu.close()
	end) 
	
	
end

function TalliMenu()
	ESX.TriggerServerCallback('Perry_Venekauppa:HaeVeneet', function(veneet)
        local elements = {}

        for k, v in pairs(veneet) do 
            table.insert(elements, { label = v['boat'], value = "otavene" })
        end

        if ( #elements == 0 ) then
            table.insert(elements, { label = Config.Texts.NoBoats,})
        end
		
		MenuData.Open(

			'default', GetCurrentResourceName(), 'bossboss_talli',

			{

				title    = Config.Texts.Title,

				subtext    = Config.Texts.SubText,

				align    = 'top-left',

				elements = elements,

			},

			function(data, menu)
			
			local category = data.current.value
			local boat = data.current.label
			print(boat)
			
			if category == 'otavene' then
				menu.close()
				TriggerEvent('elrp:spawnBoat', boat)
			end
		end, function(data, menu)
			menu.close()
		end) 
	end)
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)


    --Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function VeneMenu()

    local playercoords = GetEntityCoords(PlayerPedId())
    if canChange == true then
        canChange = false
        PreView (veneet[1].Param.Model)
        canChange = true
    end


	MenuData.CloseAll()
	MenuData.Open('default', GetCurrentResourceName(), 'vene_menu',

        {

            title    = Config.Texts.Title,

            subtext    = Config.Texts.SubText,

            align    = 'top-left',

            elements = VeneLista,

        },

        function(data, menu)

            menu.close()
			TriggerServerEvent('elrp:buyboat', veneet[data.current.value]['Param'])
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
                PreView (veneet[data.current.value].Param.Model)
                canChange = true
            end
        end


    )

end

function GetCurrentTownName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords ,1)
    if town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("Blackwater") then
        return "Blackwater"
    elseif town_hash == GetHashKey("Braithwaite") then
        return "Braithwaite"
    elseif town_hash == GetHashKey("StDenis") then
        return "Saint Denis"
	elseif town_hash == GetHashKey("Blackwater1") then --haistapaska
        return "Blackwater1"
    else
        return "" 
    end
end

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

RegisterNetEvent( 'elrp:spawnBoat' )
AddEventHandler( 'elrp:spawnBoat', function ( boat )

	local player = PlayerPedId()

	local model = GetHashKey( boat )
	local x,y,z = table.unpack( GetOffsetFromEntityInWorldCoords( player, 0.0, 4.0, 0.5 ) )

	local heading = GetEntityHeading( player ) + 90


	RequestModel( model )

	while not HasModelLoaded( model ) do
		Wait(500)
	end
	
	zone_name = GetCurrentTownName()

	boatModel = CreateVehicle( model, Config.BoatSpawn[zone_name].x, Config.BoatSpawn[zone_name].y, Config.BoatSpawn[zone_name].z, Config.BoatSpawn[zone_name].h, 1, 1 )

	SET_PED_DEFAULT_OUTFIT (boatModel)
	Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, boatModel)

	local player = PlayerPedId()
	DoScreenFadeOut(500)
	Wait(500)
	SetPedIntoVehicle(player, boatModel, -1)
	Wait(500)
	DoScreenFadeIn(500)

end )

RegisterCommand(Config.Texts.Command, function(source, args, rawCommand) -- KILL YOURSELF COMMAND
	local ped = GetPlayerPed(PlayerId())
	local pedPos = GetEntityCoords(ped, false)
	local vene = GetVehiclePedIsIn(ped, false)
	local vehicle = GetClosestVehicle(pedPos.x,pedPos.y,pedPos.z, 5.0, GetHashKey("logwagon"), 71)
	if IsVehicleModel(vene, GetHashKey("rowboat")) or IsVehicleModel(vene, GetHashKey("skiff")) or IsVehicleModel(vene, GetHashKey("rowboatSwamp")) or IsVehicleModel(vene, GetHashKey("rowboatSwamp02")) or IsVehicleModel(vene, GetHashKey("canoe")) or IsVehicleModel(vene, GetHashKey("pirogue")) or IsVehicleModel(vene, GetHashKey("pirogue2")) or IsVehicleModel(vene, GetHashKey("canoeTreeTrunk")) then
		print("yay")
		AttachEntityToEntity(vene, vehicle, GetEntityBoneIndexByName(vehicle, 'bodyshell'), 0.0, -1.0, 0.6, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
		while true do 
			Citizen.Wait(0)
			if IsControlJustPressed(0, 0x8AAA0AD4) then
				DetachEntity(vene)
				break
			end
		end
	end
end)


function SET_PED_DEFAULT_OUTFIT ( boat )
	return Citizen.InvokeNative(0xAF35D0D2583051B0, boat, true )
end

Citizen.CreateThread(function()
    for _,marker in pairs(Config.Marker) do
        local blip = N_0x554d9d53f696d002(1664425300, marker.x, marker.y, marker.z)
        SetBlipSprite(blip, marker.sprite, 1)
        SetBlipScale(blip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, marker.name)
    end  
end)

Citizen.CreateThread(function()
    for _, zone in pairs(Config.Marker) do
        TriggerEvent("elrp_boats:CreateNPC", zone)
    end
end)

RegisterNetEvent("elrp_boats:CreateNPC")
AddEventHandler("elrp_boats:CreateNPC", function(zone)

    --if not DoesEntityExist(boatnpc) then
    
        local model = GetHashKey("A_M_M_UniBoatCrew_01")
        RequestModel(model)

        while not HasModelLoaded(model) do
            Wait(500)
        end
                
        boatnpc = CreatePed(model, zone.x, zone.y, zone.z - 0.98, zone.h,  false, true)
        Citizen.InvokeNative(0x283978A15512B2FE , boatnpc, true )
        SetEntityNoCollisionEntity(PlayerPedId(), boatnpc, false)
        SetEntityCanBeDamaged(boatnpc, false)
        SetEntityInvincible(boatnpc, true)
        FreezeEntityPosition(boatnpc, true)
        SetBlockingOfNonTemporaryEvents(boatnpc, true)
        SetModelAsNoLongerNeeded(model)
    --end
end)

function PreView (model)
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
	zone_name = GetCurrentTownName()
	lastPreView = CreateVehicle( _model, Config.BoatSpawn[zone_name].x, Config.BoatSpawn[zone_name].y, Config.BoatSpawn[zone_name].z, 1, 1 )
    while not DoesEntityExist(lastPreView) do
        Wait(1)
    end
    SetEntityAsMissionEntity(lastPreView, true, true)
    FreezeEntityPosition(lastPreView , true)
end