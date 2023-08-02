ESX = nil

local canChange = true
local lastPreView
local looping = false
local jailed = false
local jail_time

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local VORPutils = {}

TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
    TriggerServerEvent("Oku_Selli:Tarkista", charid)
end)

Citizen.CreateThread(function()
	local  avaaSellit = VORPutils.Prompts:SetupPromptGroup() --Setup Prompt Group
	
	local avaaselli = avaaSellit:RegisterPrompt("Paina", 0x8AAA0AD4, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"}) --Register your first prompt
	while true do
		sleep = 2000
		for i,v in pairs(Config.Sellit) do
			local player_coords = GetEntityCoords(PlayerPedId(), true)
			local dist = GetDistanceBetweenCoords(player_coords, v.coords, true)
			if dist < 1.0 then
				sleep = 1
				avaaSellit:ShowGroup("Sellit")
				if avaaselli:HasCompleted() then
					ESX.TriggerServerCallback('Oku_Accounts:HaeTiedotJob', function(tiedot)
						if tiedot.grade >= 2 and tiedot.job == v.job then
							local elements = {
									{label = "Poista vangittu", value = 'poista'},
									{label = "Laita selliin", value = 'laitaselliin'},
							}
							MenuData.Open(
				
								'default', GetCurrentResourceName(), 'sellit_menu_menu',
				
								{
				
									title    = 'Sellit',
				
									subtext    = '',
				
									align    = 'top-left',
				
									elements = elements,
				
								},
				
								function(data, menu)
								
								local category = data.current.value
								if category == 'poista' then
									menu.close()
									Tarkasta()
								elseif category == 'laitaselliin' then
									menu.close()	
									Selliin()
								end
							end, function(data, menu)
								menu.close()
							end) 
						else
							TriggerEvent('vorp:TipBottom', "Sinulla ei ole tarvittavaa työtä", 4000)
						end
					end)
				end
			end
		end
		Wait(sleep)
	end
end)

function Tarkasta()
	local elements = {}
	ESX.TriggerServerCallback('Oku_Accounts:HaePelaajat', function(pelaajat)

        for _, v in pairs(pelaajat) do
			local name = v.nimi
			local id = v.id

            table.insert(elements, { label = "ID: "..id, value = id })
        end

        if ( #elements == 0 ) then
            table.insert(elements, { label = 'Ei ole ketään paikalla!',})
        end

		MenuData.Open(

			'default', GetCurrentResourceName(), 'kekew_menu',

			{

				title    = 'Vapauta vangittu',

				subtext    = '',

				align    = 'center',

				elements = elements,

			},

			function(data, menu)
			
			
			TargetId = data.current.value
			menu.close()
			MenuData.Open('default', GetCurrentResourceName(), 'vehicle_shop_confirm', {
				title    = 'Haluatko varmasti vapauttaa?',
				align    = 'center',
				elements = {
					{label = "Ei", value = 'no'},
					{label = "Kyllä", value = 'yes'}
			}}, function(data2, menu2)
				if data2.current.value == 'yes' then
					menu2.close()
					TriggerServerEvent("Oku_Selli:ulos", TargetId)
				elseif data2.current.value == 'no' then
					print("Ei vapautettu")
					menu2.close()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end) 
	end)
end

function Selliin()
	local elements = {
			{label = "Saint Denis", value = 'denis'},
			{label = "Valentine", value = 'valentine'},
	}
	MenuData.Open(

		'default', GetCurrentResourceName(), 'sellit2_menu_menu',

		{

			title    = 'Virkavalta',

			subtext    = 'Virkavallan sellit',

			align    = 'top-left',

			elements = elements,

		},

		function(data, menu)
		
		local category = data.current.value
		if category == 'denis' then
			menu.close()
			Denis()
		elseif category == 'valentine' then
			menu.close()
			Valentine()
		end
	end, function(data, menu)
		menu.close()
	end) 
end

local sellit = {

	[1] = {
		['Text'] = "Selli1",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Coords'] = vector3(2502.91, -1308.94, 47.95),
			['Coords2'] = vector3(2502.92, -1306.94, 48.95),
			['Kaupunki'] = "Saint-Denis",
			['Model'] = "s_m_m_ambientblwpolice_01",
			['Heading'] = 1,
			['Selli'] = "Selli1",
		}
	},

	[2] = {
		['Text'] = "Selli2",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Coords'] = vector3(2502.91, -1308.94, 47.95),
			['Coords2'] = vector3(2503.14, -1310.78, 48.95),
			['Kaupunki'] = "Saint-Denis",
			['Model'] = "s_m_m_ambientblwpolice_01",
			['Heading'] = 174.79,
			['Selli'] = "Selli2",
		}
	},

	[3] = {
		['Text'] = "Selli3",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Coords'] = vector3(2499.28, -1308.8, 47.95),
			['Coords2'] = vector3(2499.01, -1306.95, 48.95),
			['Kaupunki'] = "Saint-Denis",
			['Model'] = "s_m_m_ambientblwpolice_01",
			['Heading'] = 4.24,
			['Selli'] = "Selli3",
		}
	},

	[4] = {
		['Text'] = "Selli4",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Coords'] = vector3(2499.28, -1308.8, 47.95),
			['Coords2'] = vector3(2499.28, -1308.8, 47.95),
			['Kaupunki'] = "Saint-Denis",
			['Model'] = "s_m_m_ambientblwpolice_01",
			['Heading'] = 180.17,
			['Selli'] = "Selli4",
		}
	},
	
}

local Sellit = {}
for k,v in pairs(sellit) do

    table.insert(Sellit, {label = v["Text"], value = k , desc =  "Sellit", })
end

local sellit2 = {

	[1] = {
		['Text'] = "Selli1",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Coords'] = vector3(-272.89, 809.1, 118.37),
			['Coords2'] = vector3(-273.3, 811.52, 118.37),
			['Kaupunki'] = "Valentine",
			['Model'] = "s_m_m_ambientblwpolice_01",
			['Heading'] = 7.53,
			['Selli'] = "Selli1",
		}
	},

	[2] = {
		['Text'] = "Selli2",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Coords'] = vector3(-272.89, 809.1, 118.37),
			['Coords2'] = vector3(-272.47, 807.26, 118.37),
			['Kaupunki'] = "Valentine",
			['Model'] = "s_m_m_ambientblwpolice_01",
			['Heading'] = 187.15,
			['Selli'] = "Selli2",
		}
	},
	
}

local Sellit2 = {}
for k,v in pairs(sellit2) do

    table.insert(Sellit2, {label = v["Text"], value = k , desc =  "Sellit", })
end


function Valentine()

	MenuData.Open('default', GetCurrentResourceName(), 'valentine_menu',

        {

            title    = "Sellit",

            subtext    = "Valitse sellit",

            align    = 'top-left',

            elements = Sellit2,

        },

        function(data, menu)

            menu.close()
			DeletePed(lastPreView)
			Ideet(sellit2[data.current.value]['Param'])
            if lastPreView ~= nil then
                DeletePed(lastPreView)
                while DoesEntityExist(lastPreView) do
                    Wait(0)
                end
            end

        end,

        function(data, menu)

            menu.close()
			DeletePed(lastPreView)
            DestroyAllCams(true)
            if lastPreView ~= nil then
                while DoesEntityExist(lastPreView) do
                    Wait(0)
                end
            end
        end,


        function(data, menu)
            if canChange == true then
                canChange = false
                PreView(sellit2[data.current.value].Param.Coords, sellit2[data.current.value].Param.Model, sellit2[data.current.value].Param.Heading)
                canChange = true
            end
        end


    )
end

function Denis()

	MenuData.Open('default', GetCurrentResourceName(), 'denis_menu',

        {

            title    = "Sellit",

            subtext    = "Valitse sellit",

            align    = 'top-left',

            elements = Sellit,

        },

        function(data, menu)

            menu.close()
			DeletePed(lastPreView)
			Ideet(sellit[data.current.value]['Param'])
            if lastPreView ~= nil then
                DeletePed(lastPreView)
                while DoesEntityExist(lastPreView) do
                    Wait(0)
                end
            end

        end,

        function(data, menu)

            menu.close()
			DeletePed(lastPreView)
            DestroyAllCams(true)
            if lastPreView ~= nil then
                while DoesEntityExist(lastPreView) do
                    Wait(0)
                end
            end
        end,


        function(data, menu)
            if canChange == true then
                canChange = false
                PreView(sellit[data.current.value].Param.Coords, sellit[data.current.value].Param.Model, sellit[data.current.value].Param.Heading)
                canChange = true
            end
        end


    )
end

function Ideet(paskat)
	local elements = {}
	ESX.TriggerServerCallback('Oku_Accounts:HaePelaajat', function(pelaajat)

        for _, v in pairs(pelaajat) do
			local name = v.nimi
			local id = v.id
			local etunimi = v.nimi
            table.insert(elements, { label = "ID " .. id, value = id, firstname = etunimi, lastname = sukunimi })
        end

        if ( #elements == 0 ) then
            table.insert(elements, { label = 'Ei ole ketään paikalla!',})
        end

		MenuData.Open(

			'default', GetCurrentResourceName(), 'palkkauspaallikko_menu',

			{

				title    = 'Selli',

				subtext    = '',

				align    = 'center',

				elements = elements,

			},

			function(data, menu)
			
			
			TargetId = data.current.value
			etunimi = data.current.firstname
			sukunimi = data.current.lastname
			menu.close()
			MenuData.Open('default', GetCurrentResourceName(), 'selliin_selli_menu', {
				title    = 'Oletko varma?',
				align    = 'center',
				elements = {
					{label = "Ei", value = 'no'},
					{label = "Kyllä", value = 'yes'}
			}}, function(data2, menu2)
				if data2.current.value == 'yes' then
					menu.close()
					menu2.close()
					AddTextEntry('FMMC_KEY_TIP8', 'Aseta tuomio')
					DisplayOnscreenKeyboard(7, "FMMC_KEY_TIP8", "", "", "", "", "", 99)
				
					while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
						Citizen.Wait( 0 )
					end
				
					local clientAnswer = GetOnscreenKeyboardResult()
					if tonumber(clientAnswer) == nil or tonumber(clientAnswer) <= 0 then 
						ESX.Notify(5, "Virheellinen luku")
						MenuData.CloseAll()
						return
					end
					amount = math.floor(tonumber(clientAnswer))
					TriggerServerEvent("Oku_Selli:LaitaSelliin", TargetId, paskat, amount)
				elseif data2.current.value == 'no' then
					menu2.close()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end) 
	end)
end

function PreView (coords, model, heading)
	local _model = GetHashKey( model )
    while not HasModelLoaded( _model ) do
        Wait(1)
        modelrequest( _model )
    end
    if lastPreView ~= nil then
        DeletePed(lastPreView)
        while DoesEntityExist(lastPreView) do
            Wait(1)
        end
    end
	lastPreView = CreatePed(GetHashKey( model ), coords.x, coords.y, coords.z, heading, false, false, 0, 0)
	Citizen.InvokeNative(0x283978A15512B2FE, lastPreView, true)
	FreezeEntityPosition(lastPreView, true)
    RequestAnimDict('script_common@other@unapproved')
    while not HasAnimDictLoaded('script_common@other@unapproved') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(lastPreView, 'script_common@other@unapproved', 'loop_0', 1.0, -1.0, 9999999999, 30, 0, true, 0, false, 0, false)
	SetBlockingOfNonTemporaryEvents(lastPreView, true)
	SetModelAsNoLongerNeeded(GetHashKey(model))
    while not DoesEntityExist(lastPreView) do
        Wait(1)
    end
    SetEntityAsMissionEntity(lastPreView, true, true)
    FreezeEntityPosition(lastPreView , true)
end

local koordit = nil

RegisterNetEvent("Oku_Selli:Jailiin")
AddEventHandler("Oku_Selli:Jailiin", function(time, selli, kaupunki)
    local ped = PlayerPedId()
    local time_minutes = math.floor(time/60)
	if kaupunki == "Saint-Denis" then
		if selli == "Selli1" then
			koordit = vector3(2502.97, -1306.96, 48.95)
		elseif selli == "Selli2" then
			koordit = vector3(2503.24, -1310.87, 48.95)
		elseif selli == "Selli3" then
			koordit = vector3(2499.16, -1306.78, 48.95)
		elseif selli == "Selli4" then
			koordit = vector3(2499.29, -1310.8, 48.95)
		end
		
		if not jailed then
			SetEntityCoords(ped, koordit.x, koordit.y, koordit.z)
			FreezeEntityPosition(ped, true)
			jail_time = time
			jailed = true
			TriggerEvent("vorp:TipBottom", 'Jouduit selliin '..time_minutes..' minuutiksi', 5000)
			Citizen.Wait(1000)
			FreezeEntityPosition(ped, false)
		end
	elseif kaupunki == "Valentine" then
		if selli == "Selli1" then
			koordit = vector3(-273.3, 811.52, 118.37)
		elseif selli == "Selli2" then
			koordit = vector3(-272.47, 807.26, 118.37)
		end
		
		if not jailed then
			SetEntityCoords(ped, koordit.x, koordit.y, koordit.z)
			FreezeEntityPosition(ped, true)
			jail_time = time
			jailed = true
			TriggerEvent("vorp:TipBottom", 'Jouduit selliin '..time_minutes..' minuutiksi', 5000)
			Citizen.Wait(1000)
			FreezeEntityPosition(ped, false)
		end
	end
end)

Citizen.CreateThread(function ()
    while true do
        if jailed then
            DrawTxt('SELLI: '..jail_time..' sekuntia jäljellä', 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        if jailed then
            local ped = PlayerPedId()
            local local_player = PlayerId()
            local player_coords = GetEntityCoords(ped, true)
            
            if not GetPlayerInvincible(local_player) then
                SetPlayerInvincible(local_player, true)
            end
            
            if jail_time ~= nil then
                if jail_time <= 0 then
                    local player_server_id = GetPlayerServerId(PlayerId())
                    TriggerServerEvent("Oku_Selli:ulos", player_server_id)
                else
                    jail_time = jail_time - 1
                end
            end
            Citizen.Wait(1000)
        end
        Citizen.Wait(0)
    end
end)

local perkele = nil

RegisterNetEvent("Oku_Selli:JaUlos")
AddEventHandler("Oku_Selli:JaUlos", function(kaupunki)
	if kaupunki == "Saint-Denis" then
		local local_ped = PlayerPedId()
		TriggerEvent('vorp:TipBottom', "Pääsit pois sellistä, ole ihmisiksi", 4000) 
		jailed = false
		jail_time = nil
		SetEntityCoords(local_ped, 2513.08, -1308.8, 48.97)
		SetPlayerInvincible(local_ped, false)
	elseif kaupunki == "Valentine" then
		local local_ped = PlayerPedId()
		TriggerEvent('vorp:TipBottom', "Pääsit pois sellistä, ole ihmisiksi", 4000) 
		jailed = false
		jail_time = nil
		SetEntityCoords(local_ped, -269.42, 809.81, 119.22) 
		SetPlayerInvincible(local_ped, false)
	end
end)

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

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Wait(200)
		TriggerServerEvent("Oku_Selli:Tarkista")
	end
end)

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end
