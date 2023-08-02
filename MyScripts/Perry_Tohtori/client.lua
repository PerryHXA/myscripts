local prompts = GetRandomIntInRange(0, 0xffffff)
local prompts2 = GetRandomIntInRange(0, 0xffffff)
local MenuData = {}
Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = "Paina"
	avaaPaallikkom = PromptRegisterBegin()
	PromptSetControlAction(avaaPaallikkom, 0x8AAA0AD4) 
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(avaaPaallikkom, str)
	PromptSetEnabled(avaaPaallikkom, 1)
	PromptSetVisible(avaaPaallikkom, 1)
	PromptSetStandardMode(avaaPaallikkom,1)
    PromptSetHoldMode(avaaPaallikkom, 1)
	PromptSetGroup(avaaPaallikkom, prompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,avaaPaallikkom,true)
	PromptRegisterEnd(avaaPaallikkom)
end)


Citizen.CreateThread(function()
	for k,v in pairs(Config.Tohtorit) do
		local MedicBlip = Citizen.InvokeNative(0x554D9D53F696D002,1664425300,v.kaappi)
		SetBlipSprite(MedicBlip, -1739686743, 3)
		Citizen.InvokeNative(0x662D364ABF16DE2F, MedicBlip, "BLIP_MODIFIER_MP_COLOR_1")
		SetBlipScale(MedicBlip, 0.2)
		Citizen.InvokeNative(0x9CB1A1623062F402, tonumber(MedicBlip), v.blipname)
	end
end)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = "Paina"
	avaaKaappi = PromptRegisterBegin()
	PromptSetControlAction(avaaKaappi, 0x8AAA0AD4) 
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(avaaKaappi, str)
	PromptSetEnabled(avaaKaappi, 1)
	PromptSetVisible(avaaKaappi, 1)
	PromptSetStandardMode(avaaKaappi,1)
    PromptSetHoldMode(avaaKaappi, 1)
	PromptSetGroup(avaaKaappi, prompts2)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,avaaKaappi,true)
	PromptRegisterEnd(avaaKaappi)
end)

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

------------------------------------------------------------------------------------------
------------------------------------MENUT-------------------------------------------------
------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		for k, v in pairs(Config.Tohtorit) do
			if IsPlayerNearCoords(v.kaappi) then
				if not menu then
				   
					local label  = CreateVarString(10, 'LITERAL_STRING', "Kaappi") -- TRANSLATE HERE
					PromptSetActiveGroupThisFrame(prompts2, label)

					if Citizen.InvokeNative(0xC92AC953F0A982AE,avaaKaappi) then
						Citizen.Wait(1000)
						ESX.TriggerServerCallback('Oku_Accounts:HaeTiedotJob', function(tiedot)
							if tiedot.grade >= 2 and tiedot.job == v.job then
								local job = v.job
								TriggerEvent("Perry_Kaapit:AvaaKaappi", job)
							end
						end)
					end
				end
			end
		end
    end
end)


RegisterCommand('tohtorilaskut', function()
	AvaaTohtoriMenu()
end)

function Init()
	Citizen.CreateThread(function()
		while true do
			Wait(1)
			if IsControlJustPressed(0, 0xA8E3F467 ) then--F1
				AvaaTohtoriMenu()
				Wait(1000)
			end
		end
	end)
end

AddEventHandler('onResourceStart', function(resname)
	if GetCurrentResourceName() ~= resname then
		return
	end
	Init()
end)

RegisterCommand('hp', function()
	print('MaxHealth (Outer): ',GetEntityMaxHealth(PlayerPedId()), 'Nykyinen Health (Outer): ', GetEntityHealth(PlayerPedId()))
	print('CoreHealth (Inner): ',Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 0))
	SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
	Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, 100)
end)

function AvaaTohtoriMenu()
	ESX.TriggerServerCallback('Oku_Accounts:HaeTiedotJob', function(tiedot)
		print(json.encode(tiedot))
		if tiedot.grade >= 2 and tiedot.job == "medic" then
			local elements = {
					{label = "Anna lasku", value = 'annas'}
			}
			MenuData.Open(

				'default', GetCurrentResourceName(), 'tohtori_menu',

				{

					title    = 'Tohtori',

					subtext    = 'Tohtorin valikko',

					align    = 'top-left',

					elements = elements,

				},

				function(data, menu)
				
				local category = data.current.value
				if category == 'annas' then
					menu.close()
					local closestPlayer, closestDistance = GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						TriggerEvent("vorp:TipBottom", "Ei ketään lähettyvillä", 3000)
					else
						OpenFineMenu(closestPlayer)
					end
				end
			end, function(data, menu)
				menu.close()
			end) 
		else
			print(tiedot.job)
		end
	end)
end

function OpenFineMenu(player)
	AddTextEntry('FMMC_KEY_TIP8', 'Syötä laskun nimi')
    DisplayOnscreenKeyboard(0, "FMMC_KEY_TIP8", "", "", "", "", "", 99)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait( 0 )
    end

    local name = GetOnscreenKeyboardResult()
	Citizen.Wait(200)
	maxLength = 5
	AddTextEntry('FMMC_MPM_NA', "Syötä laskun hinta")
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", maxLength)
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait( 0 )
	end

	local palkkio = GetOnscreenKeyboardResult()
	if string.len(palkkio) >= 1 and string.len(palkkio) <= 15 and palkkio ~= nil then
		TriggerServerEvent('Oku_Laskutus:sendBill', GetPlayerServerId(player), 'society_tohtori', name, palkkio)
	else
		exports['mythic_notify']:DoLongHudText('Error', 'Palkkio on virheellinen!')
	end
end

------------------------------------------------------------------------------------------
------------------------------------PÄÄLIKKÖ----------------------------------------------
------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		for k, v in pairs(Config.Tohtorit) do
			if IsPlayerNearCoords(v.boss) then
				if not menu then
					local label  = CreateVarString(10, 'LITERAL_STRING', "Johtaja") -- TRANSLATE HERE
					PromptSetActiveGroupThisFrame(prompts, label)

					if Citizen.InvokeNative(0xC92AC953F0A982AE,avaaPaallikkom) then
						Citizen.Wait(1000)
						ESX.TriggerServerCallback('Oku_Accounts:HaeTiedotJob', function(tiedot)
							if tiedot.grade == 10 and tiedot.job == v.job then
								menu = true
								avaaPaallikkomedic(v.society, v.job)
							end
						end)
					end
				end
			end
		end
    end
end)

function avaaPaallikkomedic(society, job)
	SetNuiFocus(false)
	menu = false
	ESX.TriggerServerCallback('Oku_Accounts:Haetilitiedot', function(maara)
		local elements = {
			{label = 'Sinulla on ' .. maara .. ' € tilillä',    value = ''},
			{label = 'Laita tilille rahaa',    value = 'putmoney'},
			{label = 'Ota tililtä rahaa',    value = 'takemoney'},
			{label = "Palkkaa",   value = 'palkkaa'},
			{label = "Potki",   value = 'potki'}
		}
		MenuData.Open(

			'default', GetCurrentResourceName(), 'boss',

			{

				title    = 'YLITOHTORI',

				subtext    = 'YLITOHTORIN VALIKKO',

				align    = 'top-left',

				elements = elements,

			},

			function(data, menu)
			
			if data.current.value == 'takemoney' then
				menu.close()
				AddTextEntry('FMMC_MPM_NA', "Kuinka paljon haluat ottaa?")
				DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", maxLength)
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait( 0 )
				end
				local amount = GetOnscreenKeyboardResult()
				if amount then
					TriggerServerEvent('Oku_Accounts:Nosta', amount, society)
				end
			elseif data.current.value == 'putmoney' then
				menu.close()
				AddTextEntry('FMMC_MPM_NA', "Kuinka paljon haluat laittaa?")
				DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", maxLength)
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait( 0 )
				end
				local amount = GetOnscreenKeyboardResult()
				if amount then
					TriggerServerEvent('Oku_Accounts:Talleta', amount, society)
				end
			elseif data.current.value == 'palkkaa' then
				menu.close()
				Palkkaa(job)
			elseif data.current.value == 'potki' then
				menu.close()
				Potki(society)
			end
		end, function(data, menu)
			menu.close()
		end) 
		
	end, society)
end

function Palkkaa(job)
	local elements = {}
	ESX.TriggerServerCallback('Oku_Accounts:HaePelaajat', function(pelaajat)

        for _, v in pairs(pelaajat) do
			local name = v.nimi
			local id = v.id
            table.insert(elements, { label = " ID " .. id, value = id })
        end

        if ( #elements == 0 ) then
            table.insert(elements, { label = 'Ei ole ketään paikalla!',})
        end

		MenuData.Open(

			'default', GetCurrentResourceName(), 'palkkauspaallikko_menu',

			{

				title    = 'PALKKAUS',

				subtext    = '',

				align    = 'center',

				elements = elements,

			},

			function(data, menu)
			
			
			TargetId = data.current.value
			menu.close()
			MenuData.Open('default', GetCurrentResourceName(), 'vehicle_shop_confirm', {
				title    = 'Haluatko varmasti palkata?',
				align    = 'center',
				elements = {
					{label = "Ei", value = 'no'},
					{label = "Kyllä", value = 'yes'}
			}}, function(data2, menu2)
				if data2.current.value == 'yes' then
					menu2.close()
					maxLength = 5
					AddTextEntry('FMMC_MPM_NA', "Syötä laskun hinta")
					DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", maxLength)
					while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
						Citizen.Wait( 0 )
					end
				
					local grade = tonumber(GetOnscreenKeyboardResult())

					TriggerServerEvent("Oku_Accounts:PalkkaaPelaaja", TargetId, job, grade)
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

function Potki(society)
	local elements = {}
	ESX.TriggerServerCallback('Oku_Accounts:HaePalkatut', function(employees)

		for i=1, #employees, 1 do
			local name = employees[i].firstname
			local lname = employees[i].lastname
			local grade = employees[i].grade
			local identifier = employees[i].identifier
			local charidentifier = employees[i].charidentifier

            table.insert(elements, { label = "Nimi: "..name.." "..lname.." TASO: "..grade, value = identifier, charid = charidentifier, lname = lname })
        end

        if ( #elements == 0 ) then
            table.insert(elements, { label = 'Ei ole ketään paikalla!',})
        end

		MenuData.Open(

			'default', GetCurrentResourceName(), 'potkupaallikko_menu',

			{

				title    = 'POTKUT',

				subtext    = '',

				align    = 'center',

				elements = elements,

			},

			function(data, menu)
			
			
			identifier = data.current.value
			charid = data.current.charid
			print(identifier)
			print(charid)
			menu.close()
			MenuData.Open('default', GetCurrentResourceName(), 'vehicle_shop_confirm', {
				title    = 'Haluatko varmasti potkia?',
				align    = 'center',
				elements = {
					{label = "Ei", value = 'no'},
					{label = "Kyllä", value = 'yes'}
			}}, function(data2, menu2)
				if data2.current.value == 'yes' then
					print("Potkut")
					TriggerServerEvent('slerbafixaa:fireplayer', identifier, charid) --Päivitetään suoraan 
					TriggerServerEvent("Oku_Accounts:PotkiPelaaja", identifier, charid) --Varmistetaan databasen kautta
					menu2.close()
				elseif data2.current.value == 'no' then
					print("Ei Potkittu")
					menu2.close()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end) 
	end, society)
end

------------------------------------------------------------------------------------------
------------------------------------MUUTA PASKAA------------------------------------------
------------------------------------------------------------------------------------------

RegisterCommand("die", function(source, args, rawCommand) -- KILL YOURSELF COMMAND
	local _source = source
	local pl = Citizen.InvokeNative(0x217E9DC48139933D)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
    Citizen.InvokeNative(0x697157CED63F18D4, ped, 500000, false, true, true)
end)

AddEventHandler("vorp:SelectedCharacter", function(spawnInfo)
    local playerPed = GetPlayerPed(PlayerId())
    Citizen.InvokeNative(0xDE1B1907A83A1550, playerPed, 0) --SetHealthRechargeMultiplier
	Init()
end)

function IsPlayerNearCoords(x, y, z)
    local playerx, playery, playerz = table.unpack(GetEntityCoords(PlayerPedId(), 0))
    local distance = Vdist2(playerx, playery, playerz, x, y, z, true) -- USE VDIST

    if distance < 1 then
        return true
    end
end

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