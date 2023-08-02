local timerCount = 5
local timers = false

Citizen.CreateThread(function()
	TriggerServerEvent("Perry_Fort:Otarahuskilia")
end)

local prompts = GetRandomIntInRange(0, 0xffffff)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = "Paina"
	AvaaMenu = PromptRegisterBegin()
	PromptSetControlAction(AvaaMenu, 0x0F39B3D4) 
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(AvaaMenu, str)
	PromptSetEnabled(AvaaMenu, 1)
	PromptSetVisible(AvaaMenu, 1)
	PromptSetStandardMode(AvaaMenu,1)
    PromptSetHoldMode(AvaaMenu)
	PromptSetGroup(AvaaMenu, prompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,AvaaMenu,true)
	PromptRegisterEnd(AvaaMenu)
end)
	
RegisterNetEvent('Perry_Fort:Aloitusta') 
AddEventHandler('Perry_Fort:Aloitusta', function()
	for i,v in pairs(Config.Fortit) do
		local coords = GetEntityCoords(PlayerPedId())
		local betweencoords = GetDistanceBetweenCoords(coords, v.position, true)
		if betweencoords <= 1.5 then
			TriggerServerEvent("Perry_Fort:TarkastaRyosto", v.name)
		end
	end
end)

RegisterNetEvent('Perry_Fort:AvaaMenu') 
AddEventHandler('Perry_Fort:AvaaMenu', function(money, fort)
	SetNuiFocus(false)
    local bossMenu = {
        {
            header = "Tilillä on ".. money.. "$",
            isMenuHeader = true,
        },
        {
            header = "Laita rahaa 5$",
            params = {
				isServer = true,
                event = "Perry_Fort:LaitaRahaa",
                args = {
                    fortti = fort,
					rahaa = money
                }
            }
        },
    }
    exports['qbr-menu']:openMenu(bossMenu)
end)


local onmenu = false

Citizen.CreateThread(function()
	while true do
		sleep = 2000
		for i,v in pairs(Config.Fortit) do
			local coords = GetEntityCoords(PlayerPedId())
			local betweencoords = GetDistanceBetweenCoords(coords, v.menu, true)
			if betweencoords <= 1.5 and not onmenu then
				sleep = 1
				local label  = CreateVarString(10, 'LITERAL_STRING', "LINNAKE") -- TRANSLATE HERE
				PromptSetActiveGroupThisFrame(prompts, label)
				if Citizen.InvokeNative(0xC92AC953F0A982AE,AvaaMenu) then
					onmenu = true
					TriggerServerEvent("Perry_Fort:TarkistaOmistaja", v.name)
					Citizen.Wait(2000)
					onmenu = false
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

RegisterNetEvent('Perry_Fort:AloitaValtaaminen') 
AddEventHandler('Perry_Fort:AloitaValtaaminen', function(fort)
	timers = true
	TriggerEvent("Perry_Fort:startTimers")
	while timers do
		Citizen.Wait(0)
		DrawTxt("Suojele aluetta ~e~"..timerCount.." sekuntia", 0.50, 0.95, 0.3, 0.3, true, 255, 255, 255, 255, true)
		local playerPed = PlayerPedId()
		local playerdead = IsPedDeadOrDying(playerPed, 1)
		if playerdead then
			timers = false
		end
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords, 336.64, 1506.18, 181.87, true)
		if betweencoords > 70.0 then
			timers = false
		end
		if timerCount == 0 then
			Citizen.Wait(1000)
			TriggerServerEvent("Perry_Fort:Vallattu", fort)
		end
	end
end)

RegisterNetEvent("Perry_Fort:StarttaaNPC") 
AddEventHandler("Perry_Fort:StarttaaNPC",function() -- Ehkä laskuri ? 
	--NPCWAVE()
	--Citizen.Wait(5000)
	--NPCWAVE()
end)

function NPCWAVE()
    while not HasModelLoaded( GetHashKey("s_m_m_valdeputy_01") ) do
        Wait(500)
        RequestModel( GetHashKey("s_m_m_valdeputy_01") )
    end
	local playerPed = PlayerPedId()
	AddRelationshipGroup('NPC')
	AddRelationshipGroup('PlayerPed')
	for k,v in pairs(Config.npcspawn) do
		pedy = CreatePed(GetHashKey("s_m_m_valdeputy_01"),v.x,v.y,v.z,0, true, false, 0, 0)
		SetPedRelationshipGroupHash(pedy, 'NPC')
        GiveWeaponToPed_2(pedy, 0x64356159, 500, true, 1, false, 0.0)
		Citizen.InvokeNative(0x283978A15512B2FE, pedy, true)
		Citizen.InvokeNative(0xF166E48407BAC484, pedy, PlayerPedId(), 0, 0)
		FreezeEntityPosition(pedy, false)
		TaskCombatPed(pedy,playerped, 0, 16)
	end
end

AddEventHandler("Perry_Fort:startTimers",function()
	Citizen.CreateThread(function()
		while timers do
			Citizen.Wait(1000)
			if timerCount >= 0 then
				timerCount = timerCount - 1
			else
				timers = false
				timerCount = 600
			end
		end
	end)
end)

Citizen.CreateThread(function()
local iLocal_21 = CreateVolumeAggregateWithCustomName("Fort Wallace - m_volThreatVolume Agg");
    Citizen.InvokeNative(0x39816F6F94F385AD, iLocal_21, 343.4911, 1484.906, 183.6585, 0, 0, 125.4594, 50.44129, 27.58693, 15.20348);
    Citizen.InvokeNative(0x39816F6F94F385AD, iLocal_21, 366.8338, 1481.555, 183.3052, 0, 0, 70.84903, 9.450991, 11.24788, 14.86582);
    Citizen.InvokeNative(0x39816F6F94F385AD, iLocal_21, 361.6927, 1499.326, 183.0759, 0, 0, 14.50761, 15.72725, 35.53953, 16.71587);
    Citizen.InvokeNative(0x39816F6F94F385AD, iLocal_21, 327.8768, 1483.835, 182.8865, 0, 0, -11.76057, 17.00056, 10.34268, 16.34857);
    Citizen.InvokeNative(0x39816F6F94F385AD, iLocal_21, 319.2722, 1495.286, 184.5413, 0, 0, -53.96134, 23.05555, 18.03384, 21.16078);
    Citizen.InvokeNative(0x39816F6F94F385AD, iLocal_21, 320.7645, 1509.291, 188.6127, 0, 0, -25.21897, 4.516489, 7.110216, 18.25474);
    Citizen.InvokeNative(0x39816F6F94F385AD, iLocal_21, 324.6142, 1502.853, 184.9036, 0, 0, -24.95285, 14.96967, 13.84794, 21.22798);
    Citizen.InvokeNative(0x39816F6F94F385AD, iLocal_21, 350.3736, 1501.781, 184.2531, 0, 0, 33.49929, 9.61958, 30.69061, 13.84341);
    Citizen.InvokeNative(0x39816F6F94F385AD, iLocal_21, 352.1387, 1513.729, 182.7722, 0, 0, 24.7492, 10.80241, 11.25904, 15.89185);
    Citizen.InvokeNative(0x39816F6F94F385AD, iLocal_21, 355.6973, 1518.419, 184.7034, 0, 0, 0, 1.984145, 5.500231, 12.25786);
    Citizen.InvokeNative(0x39816F6F94F385AD, iLocal_21, 357.9312, 1517.985, 184.7034, 0, 0, -16.95034, 4.391377, 5.500231, 12.25786);
    Citizen.InvokeNative(0xBCE668AAF83608BE, iLocal_21, 362.5482, 1516.343, 182.8423, 0, 0, 0, 3.488632, 3.541783, 9.602388);
    Citizen.InvokeNative(0xBCE668AAF83608BE, iLocal_21, 366.5602, 1473.809, 182.5569, 0, 0, 0, 4, 4, 7.516581);
    local iLocal_22 = CreateVolumeAggregateWithCustomName("Fort Wallace - m_volRegistrationVolume Agg");
    Citizen.InvokeNative(0x6E0D3C3F828DA773, iLocal_22, iLocal_21);
    Citizen.InvokeNative(0xBCE668AAF83608BE, iLocal_22, 345.1969, 1487.955, 182.5569, 0, 0, 0, 63.65347, 68.76788, 13.83329);
    local sLocal_23 = "OLD_FORT_WALLACE";
    CreateGuardZone(sLocal_23);
    Citizen.InvokeNative(0x8C598A930F471938, sLocal_23, iLocal_22);
    Citizen.InvokeNative(0xA1B0E6301E2E02A6, sLocal_23, iLocal_21);
    Citizen.InvokeNative(0x35815F372D43E1E5, sLocal_23, iLocal_21);
    Citizen.InvokeNative(0xAD3E07C37A7C1ADC, sLocal_23, iLocal_21);
    SetGuardZonePosition(sLocal_23, 346.9555, 1488.217, 182.0683);
    Citizen.InvokeNative(0xA8A74AA79FB67159, sLocal_23, iLocal_21);
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end