ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

local VORPutils = {}

TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)

Citizen.CreateThread(function()
    for i,v in pairs(Config.Stations) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.blipcoords)
        SetBlipSprite(blip, -266617465, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, v.blipname)
    end
end)

Citizen.CreateThread(function()
	local  avaaKaappiVirkavalta = VORPutils.Prompts:SetupPromptGroup() --Setup Prompt Group
	
	local avaakaappi = avaaKaappiVirkavalta:RegisterPrompt("Paina", 0x8AAA0AD4, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"}) --Register your first prompt
	while true do
		sleep = 2000
		for i,v in pairs(Config.Stations) do
			local player_coords = GetEntityCoords(PlayerPedId(), true)
			local dist = GetDistanceBetweenCoords(player_coords, v.kaappi, true)
			if dist < 1.0 then
				sleep = 1
				avaaKaappiVirkavalta:ShowGroup("Kaappi")
				if avaakaappi:HasCompleted() then
					ESX.TriggerServerCallback('Oku_Accounts:HaeTiedotJob', function(tiedot)
						if tiedot.grade >= 3 and tiedot.job == v.job then
							TriggerEvent("Perry_Kaapit:AvaaKaappi", v.job)
						end
					end)
				end
			end
		end
		Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	local  avaaKauppaVirkavalta = VORPutils.Prompts:SetupPromptGroup() --Setup Prompt Group
	
	local avaakauppa = avaaKauppaVirkavalta:RegisterPrompt("Paina", 0x8AAA0AD4, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"}) --Register your first prompt
	while true do
		sleep = 2000
		for i,v in pairs(Config.Stations) do
			local player_coords = GetEntityCoords(PlayerPedId(), true)
			local dist = GetDistanceBetweenCoords(player_coords, v.kauppa, true)
			if dist < 1.0 then
				sleep = 1
				avaaKauppaVirkavalta:ShowGroup("Asekaappi")
				if avaakauppa:HasCompleted() then
					ESX.TriggerServerCallback('Oku_Accounts:HaeTiedotJob', function(tiedot)
						if tiedot.grade >= 3 and tiedot.job == v.job then
							AvaaKauppaVirkavalta() 
						end
					end)
				end
			end
		end
		Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	local  avaaPaallikko = VORPutils.Prompts:SetupPromptGroup() --Setup Prompt Group
	
	local avaapaallikko = avaaPaallikko:RegisterPrompt("Paina", 0x8AAA0AD4, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"}) --Register your first prompt
	while true do
		sleep = 2000
		for i,v in pairs(Config.Stations) do
			local player_coords = GetEntityCoords(PlayerPedId(), true)
			local dist = GetDistanceBetweenCoords(player_coords, v.paallikko, true)
			if dist < 1.0 then
				sleep = 1
				avaaPaallikko:ShowGroup("Päällikkö")
				if avaapaallikko:HasCompleted() then
					ESX.TriggerServerCallback('Oku_Accounts:HaeTiedotJob', function(tiedot)
						if tiedot.grade >= 10 and tiedot.job == v.job then
							AvaaPaallikkoPoliisi(v.society)
						end
					end)
				end
			end
		end
		Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	local  avaaPaallikko = VORPutils.Prompts:SetupPromptGroup() --Setup Prompt Group
	
	local avaapaallikko = avaaPaallikko:RegisterPrompt("Paina", 0x8AAA0AD4, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"}) --Register your first prompt
	while true do
		sleep = 2000
		for i,v in pairs(Config.Stations) do
			local player_coords = GetEntityCoords(PlayerPedId(), true)
			local dist = GetDistanceBetweenCoords(player_coords, v.vankkurit, true)
			if dist < 1.0 then
				sleep = 1
				avaaPaallikko:ShowGroup("Ota ajoneuvo")
				if avaapaallikko:HasCompleted() then
					ESX.TriggerServerCallback('Oku_Accounts:HaeTiedotJob', function(tiedot)
						if tiedot.grade >= 1 and tiedot.job == v.job or tiedot.job == "medic" then
							OtaVankkurit(v.vankkuricoords, v.vankkuriheading)
						end
					end)
				end
			end
		end
		Wait(sleep)
	end
end)

function OtaVankkurit(coordsit, heading)
	SetNuiFocus(false)
    local bossMenu = {
        {
            header = "Mitä haluat ottaa tallista?",
            isMenuHeader = true,
        },
        {
            header = "Vankilavaunut",
            params = {
				isServer = false,
                event = "Perry_Virkavalta:Ajokki",
                args = {
                    ajoneuvo = "wagonPrison01x",
					coordsit = coordsit,
					heading = heading 
                }
            }
        },
        {
            header = "Kuumailmapallo",
            params = {
				isServer = false,
                event = "Perry_Virkavalta:Ajokki",
                args = {
                    ajoneuvo = "hotAirBalloon01",
					coordsit = coordsit,
					heading = heading 
                }
            }
        },
    }
    exports['qbr-menu']:openMenu(bossMenu)
end

RegisterNetEvent('Perry_Virkavalta:Ajokki')
AddEventHandler('Perry_Virkavalta:Ajokki', function(args)
	local ajoneuvo = args.ajoneuvo
	local coordsit = args.coordsit
	local heading = args.heading
	print(ajoneuvo)
	Citizen.Wait(1000)
	RequestModel( GetHashKey(ajoneuvo) )
	while not HasModelLoaded( GetHashKey(ajoneuvo) ) do
		Wait(500)
	end
	PoliceCartVeh = CreateVehicle(GetHashKey(ajoneuvo), coordsit, heading, true, false)
	TriggerEvent("vorp:TipBottom", "Toimitettu!", 5000)
end)

RegisterCommand('vihko', function()
	AvaaVirkavaltaMenu()
	--Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("world_human_write_notebook"), 100000,true,false, false, false)
end)

RegisterNetEvent('Perry_Poliisijobi:LokiSilma')
AddEventHandler('Perry_Poliisijobi:LokiSilma', function()
	ESX.TriggerServerCallback('Perry_Poliisijobi:HaeTiedotJob', function(tiedot)
		if tiedot.grade >= 9 and tiedot.job == "police" or tiedot.job == "sheriff" then
			AvaaLokikirja()
		end
	end)
end)

function AvaaKauppaVirkavalta()
	SetNuiFocus(false)
	menu = false
		local elements = {
			{label = '[Revolveri] - Navy 25$', hinta = 20, setti = "pyssy", value = 'WEAPON_REVOLVER_NAVY'},
			{label = '[Repeater] - Winchester 35$', hinta = 30,setti = "pyssy", value = 'WEAPON_REPEATER_WINCHESTER'},
			{label = '[Lasso] - Lasso 5$', hinta = 5,setti = "pyssy", value = 'WEAPON_LASSO'},
			{label = '[Veitsi] - Veitsi 5$', hinta = 5,setti = "pyssy", value = 'WEAPON_MELEE_KNIFE'},
			{label = 'Käsiraudat 1$', hinta = 1,setti = "itemi", value = 'kasirauta'},
			{label = 'Avaimet 1$', hinta = 1,setti = "itemi", value = 'kasiavain'},
			{label = 'Virkapilli 1$', hinta = 1,setti = "itemi", value = 'whistle'},
			{label = 'Arkistot 1$', hinta = 1,setti = "itemi", value = 'notebook'},
			{label = 'Reolverin ammuksia - 1$', hinta = 1,setti = "itemi", value = 'ammorevolvernormal'},
			{label = 'Repeaterin ammuksia - 1$', hinta = 1,setti = "itemi", value = 'ammorepeaternormal'},
		}
		MenuData.Open(

			'default', GetCurrentResourceName(), 'boss',

			{

				title    = 'TUKKU',

				subtext    = 'TUKKU VALIKKO',

				align    = 'top-left',

				elements = elements,

			},

			function(data, menu)
			
		if data.current.setti == 'pyssy' then
				menu.close()
				MenuData.Open('default', GetCurrentResourceName(), 'adawdawdadwadwa', {
				title    = 'Ostetaanko Ase?',
				align    = 'top-left',
				elements = {
				{label = "Ei", value = 'no'},
				{label = "Kyllä", value = 'yes'}
				}}, function(data2, menu2)
				if data2.current.value == 'yes' then
					TriggerServerEvent('Perry_Poliisijobi:ostapyssy', data.current.value, data.current.hinta)
					menu2.close()
				elseif data2.current.value == 'no' then
					TriggerEvent('vorp:TipBottom', "Et ostanut asetta", 3000)
					menu2.close()
					end
				end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.setti == 'itemi' then
			menu.close()
			MenuData.Open('default', GetCurrentResourceName(), 'adawdawdad222222wadwa', {
			title    = 'Ostetaanko Tavara?',
			align    = 'top-left',
			elements = {
			{label = "Ei", value = 'no'},
			{label = "Kyllä", value = 'yes'}
			}}, function(data2, menu2)
			if data2.current.value == 'yes' then
				TriggerServerEvent('Perry_Poliisijobi:ostaitemi', data.current.value, data.current.hinta)
				menu2.close()
			elseif data2.current.value == 'no' then
				TriggerEvent('vorp:TipBottom', "Et ostanut tavaraa", 3000)
				menu2.close()
				end
			end, function(data2, menu2)
			menu2.close()
			end)
			end
		end, function(data, menu)
		menu.close()
	end) 
end

function AvaaLokikirja()
	local elements = {
		{label = "Tarkista kävijät (Guarma)", value = 'tarkista'}
	}
	MenuData.Open(

		'default', GetCurrentResourceName(), 'lokikirja_menu',

		{

			title    = 'Virkavalta',

			subtext    = 'Lokikirja',

			align    = 'top-left',

			elements = elements,

		},

		function(data, menu)
		
		local category = data.current.value
		if category == 'tarkista' then
			ESX.TriggerServerCallback('Perry_Virkavalta:HaeKavijat', function(kavijat)
				local elements = {}

				for k, v in pairs(kavijat) do 
					table.insert(elements, { label = v['nimi'].." "..v['sukunimi'].." AIKA:"..v['aika'], value = "poista", identifier = v['identifier'], charid = v['charid'], aika = v['aika'] })
				end

				if ( #elements == 0 ) then
					table.insert(elements, { label = 'Tyhjä!',})
				end
				
				MenuData.Open(

					'default', GetCurrentResourceName(), 'lokikirjaa_talli',

					{

						title    = 'GUARMA',

						subtext    = 'Kävijät',

						align    = 'top-left',

						elements = elements,

					},

					function(data, menu)
					local category = data.current.value
					local identifier = data.current.identifier
					local charid = data.current.charid
					local aika = data.current.aika
					
					if category == 'poista' then
						menu.close()
						TriggerServerEvent("Perry_Virkavalta:PoistaKavija", identifier, charid, aika)
					end
				
				end, function(data, menu)
					menu.close()
				end) 
			end)
		end
	end, function(data, menu)
		menu.close()
	end) 	
end


local showing = false

function AvaaVirkavaltaMenu()

	ESX.TriggerServerCallback('Perry_Poliisijobi:HaeTiedotJob', function(tiedot)
		if tiedot.grade >= 1 and tiedot.job == "police" or tiedot.grade >= 1 and tiedot.job == "sheriff" then
			local elements = {
					{label = "Laita linnaan", value = 'linnaan'},
					{label = "Laita kärryihin", value = 'lajoneuvo'},
					{label = "Ota kärryistä", value = 'otaajo'},
					{label = "Tarkista paperit", value = 'tarkistap'},
					{label = "Anna sakko", value = 'annas2'},
					{label = "Tarkista laskut", value = 'laskut'},
					{label = "Raudoita / Poista Raudat", value = 'raudoita'}
			}
			MenuData.Open(

				'default', GetCurrentResourceName(), 'bountyboard_menu',

				{

					title    = 'VALIKKO',

					subtext    = tiedot.job,

					align    = 'top-left',

					elements = elements,

				},

				function(data, menu)
				
				local category = data.current.value
				if category == 'linnaan' then
					menu.close()
					local closestPlayer, closestDistance = GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then              
                        TriggerEvent("Perry_Jail:LaitaLinnaanKekw", GetPlayerServerId(closestPlayer)) 
					else
						exports['mythic_notify']:DoLongHudText('Error', 'Ei ketään lähettyvillä!')
						Citizen.Wait(1000)
					end
				elseif category == 'lajoneuvo' then
					--menu.close()
					local closestPlayer, closestDistance = GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 5.0 then    
						print("Toimii")          
                        TriggerServerEvent("vorp_ml_policejob:metervehiculo", GetPlayerServerId(closestPlayer))  
					else
						exports['mythic_notify']:DoLongHudText('Error', 'Ei ketään lähettyvillä!')
						Citizen.Wait(1000)						
					end
				elseif category == 'tutkik' then
					menu.close()
					local closestPlayer, closestDistance = GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						TriggerServerEvent('xakra_steal:ReloadInventory', GetPlayerServerId(closestPlayer))
						TriggerServerEvent('xakra_steal:OpenInventory', GetPlayerServerId(closestPlayer))
					else
						exports['mythic_notify']:DoLongHudText('Error', 'Ei ketään lähettyvillä!')
						Citizen.Wait(1000)
					end
				elseif category == 'tarkistap' then
					menu.close()
					local closestPlayer, closestDistance = GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						TriggerServerEvent("syn_id:open2",GetPlayerServerId(closestPlayer))
					else
						exports['mythic_notify']:DoLongHudText('Error', 'Ei ketään lähettyvillä!')
						Citizen.Wait(1000)
					end
				elseif category == 'laskut' then
					menu.close()
					local closestPlayer, closestDistance = GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						OpenUnpaidBillsMenu(closestPlayer)
					else
						exports['mythic_notify']:DoLongHudText('Error', 'Ei ketään lähettyvillä!')
						Citizen.Wait(1000)
					end
				elseif category == 'annas2' then
					menu.close()
					local closestPlayer, closestDistance = GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						OpenFineMenu2(closestPlayer, tiedot.job)
					else
						exports['mythic_notify']:DoLongHudText('Error', 'Ei ketään lähettyvillä!')
						Citizen.Wait(1000)
					end
				elseif category == 'raudoita' then
					menu.close()
					HandcuffPlayer()
				elseif category == 'otaajo' then
					menu.close()
					local closestPlayer, closestDistance = GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						TriggerServerEvent("vorp_ml_policejob:sacarvehiculo", GetPlayerServerId(closestPlayer))   
					else
						exports['mythic_notify']:DoLongHudText('Error', 'Ei ketään lähettyvillä!')
						Citizen.Wait(1000)						
					end
				elseif category == 'lassolukko' then
					menu.close()
					local closestPlayer, closestDistance = GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						TriggerServerEvent("ml_policejob:lassoplayer", GetPlayerServerId(closestPlayer))         
					else
						exports['mythic_notify']:DoLongHudText('Error', 'Ei ketään lähettyvillä!')
						Citizen.Wait(1000)						
					end
				end
			end, function(data, menu)
				menu.close()
				ClearPedTasks(PlayerPedId())
			end) 
		end
	end)
end

function OpenFineMenu2(player, job)
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
		print(job)
		if job == "police" then
			TriggerServerEvent('Oku_Laskutus:sendBill', GetPlayerServerId(player), 'society_police', name, palkkio)
		elseif job == "sheriff" then
			TriggerServerEvent('Oku_Laskutus:sendBill', GetPlayerServerId(player), 'society_sheriff', name, palkkio)
		end
	else
		exports['mythic_notify']:DoLongHudText('Error', 'Palkkio on virheellinen!')
	end
end

RegisterNetEvent('ml_policejob:hogtie')
AddEventHandler('ml_policejob:hogtie', function()
	isLasso = not isLasso
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if isLasso then
            TaskKnockedOutAndHogtied(playerPed, false, false)
			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			DisplayRadar(false)
        elseif not isLasso then
            ClearPedTasksImmediately(playerPed, true, false)
			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			DisplayRadar(true)
		end
	end)
end)

RegisterNetEvent('Perry_Poliisi:meter')
AddEventHandler('Perry_Poliisi:meter', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = GetVehicleCoords(coords)
	
    print('Coche'..vehicle)
    print('Coordenadas'..coords)
    local seats = 1 
    while seats <= 6 do
        if Citizen.InvokeNative(0xE052C1B1CAA4ECE4, vehicle, seats) then
            -- print('Vehiclue seat')
            Citizen.InvokeNative(0xF75B0D629E1C063D, ped, vehicle, seats)
			SetRelationshipBetweenGroups(1, `PLAYER`, `PLAYER`)
            break
        end
            if seats == 7 then
                -- print('ESTO ESTA LLENO MUCHACHO')
                break
            end
        
        seats = seats + 1
        print('asientos'..seats)
    end
end)
GetVehicles = function()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

function GetVehicleCoords(coords)
    local vehicles        = GetVehicles()
	local closestDistance = -1
	local closestVehicle  = -1
	local coords          = coords

	if coords == nil then
		local playerPed = PlayerPedId()
		coords          = GetEntityCoords(playerPed)
	end

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end

    return closestVehicle, closestDistance
end

RegisterNetEvent('vorp_ml_policejob:sacar')
AddEventHandler('vorp_ml_policejob:sacar', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehicleCoords(coords)
    local inVehicle = GetVehiclePedIsIn(playerPed, false)
    local flag = 16
    TaskLeaveVehicle(playerPed, vehicle, flag)
	SetRelationshipBetweenGroups(5, `PLAYER`, `PLAYER`)
end)

function HandcuffPlayer()
    local player, distance = GetClosestPlayer()

    if distance == -1 or distance > 3.0 then
		exports['mythic_notify']:DoLongHudText('Error', "Ei ketään lähettyvillä")
        return
    end

    TriggerServerEvent('lawmen:handcuff', GetPlayerServerId(player))
end

RegisterNetEvent('lawmen:handcuff')
AddEventHandler('lawmen:handcuff', function()
	isHandcuffed = not isHandcuffed
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if isHandcuffed then
			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
        else
            ClearPedSecondaryTask(playerPed)
            SetEnableHandcuffs(playerPed, false)
            DisablePlayerFiring(playerPed, false)
            SetPedCanPlayGestureAnims(playerPed, true)
		end
	end)
end)

function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('Oku_Laskutus:getTargetBills', function(bills)
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - <span style="color:red;">%s</span>'):format(bill.label, ESX.Math.GroupDigits(bill.amount).."$"),
				billId = bill.id
			})
		end

		MenuData.Open('default', GetCurrentResourceName(), 'billing', {
			title    = "Laskut",
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function AvaaPaallikkoPoliisi(society)
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

				title    = 'POLIISIPÄÄLIKKÖ',

				subtext    = 'POLIISIPÄÄLLIKÖN VALIKKO',

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
				Palkkaa()
			elseif data.current.value == 'potki' then
				menu.close()
				Potki()
			end
		end, function(data, menu)
			menu.close()
		end) 
		
	end, society)
end

function UnblockMenuInput()
    Citizen.CreateThread( function()
        Citizen.Wait( 150 )
        blockinput = false 
    end )
end

function Potki()
	local elements = {}
	local society = "sheriff"
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

function Palkkaa()
	local elements = {}
	ESX.TriggerServerCallback('Oku_Accounts:HaePelaajat', function(pelaajat)

        for _, v in pairs(pelaajat) do
			local name = v.nimi
			local id = v.id
            table.insert(elements, { label = "ID "..id, value = id })
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
					print("Palkattu")
					AddTextEntry('FMMC_KEY_TIP8', 'Aseta työarvo')
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
						local grade = math.floor(tonumber(clientAnswer))
						local job = "sheriff"
						TriggerServerEvent('slerbafixaa:palkkaa', TargetId, grade)
						TriggerServerEvent("Oku_Accounts:PalkkaaPelaaja", TargetId, job, grade)
				elseif data2.current.value == 'no' then
					print("Ei Palkattu")
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

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

