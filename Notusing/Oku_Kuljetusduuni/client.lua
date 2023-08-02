Citizen.CreateThread(function()
	Citizen.Wait(1000)
	SpawnNpcs()
end)

local modeli = "cs_crackpotinventor"
local speaking = false

local prompts = GetRandomIntInRange(0, 0xffffff)
local prompts2 = GetRandomIntInRange(0, 0xffffff)

--PROPMT
Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = "Puhu"
	avaaSalaisuus = PromptRegisterBegin()
	PromptSetControlAction(avaaSalaisuus,  0x8AAA0AD4) 
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(avaaSalaisuus, str)
	PromptSetEnabled(avaaSalaisuus, 1)
	PromptSetVisible(avaaSalaisuus, 1)
	PromptSetStandardMode(avaaSalaisuus,1)
    PromptSetHoldMode(avaaSalaisuus, 1)
	PromptSetGroup(avaaSalaisuus, prompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,avaaSalaisuus,true)
	PromptRegisterEnd(avaaSalaisuus)
end)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = "Avaa"
	avaaOvi = PromptRegisterBegin()
	PromptSetControlAction(avaaOvi,  0x8AAA0AD4) 
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(avaaOvi, str)
	PromptSetEnabled(avaaOvi, 1)
	PromptSetVisible(avaaOvi, 1)
	PromptSetStandardMode(avaaOvi,1)
    PromptSetHoldMode(avaaOvi, 1)
	PromptSetGroup(avaaOvi, prompts2)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,avaaOvi,true)
	PromptRegisterEnd(avaaOvi)
end)

local paikat = { 
	[1] = {x = 2326.05, y = 1989.43, z = 164.05, h = 164.79},  
	--[2] = {x = 1950.36, y = 486.79, z = 130.38, h = 330.04, xx = 1949.63, yy = 485.97, zz = 130.26, hh = 242.38},  
    --[3] = {x = 1284.77, y = 279.46, z = 87.39, h = 60.9, xx = 1285.77, yy = 278.5, zz = 87.58, hh = 325.84},  
    --[4] = {x = -2269.08, y = -612.58, z = 163.41, h = 112.89, xx = -2267.83, yy = -612.36, zz = 163.47, hh = 15.07},  -- UUS INTIAANIKYLÄ
    --[5] = {x = -1192.22, y = -350.14, z = 98.28, h = 342.5, xx = -1192.96, yy = -351.19, zz = 98.45, hh = 248.1}, 
    --[6] = {x = 597.09, y = -534.55, z = 75.88, h = 328.33, xx = 596.21, yy = -535.55, zz = 76.06, hh = 242.8}, --Valentinen ja rhodes välillä, lähemmäs valentinee
}

RegisterNetEvent('Oku_Kuljetusduuni:Aloita')
AddEventHandler('Oku_Kuljetusduuni:Aloita', function()
	AvaaKeskustelu()
end)

RegisterNetEvent('Oku_Kuljetusduuni:AloitaSekunda')
AddEventHandler('Oku_Kuljetusduuni:AloitaSekunda', function()
	exports['progressBars']:startUI(4000, "Yritetään käynnistää")
	Citizen.Wait(4000)
	FreezeEntityPosition(PlayerPedId(), true)
	exports["memorygame"]:thermiteminigame(10, 3, 3, 10,
	function() -- success
		FreezeEntityPosition(PlayerPedId(), false)
		exports['mythic_notify']:DoLongHudText('Error', 'Kone käynnistetty!')
	end,
	function() -- failure
		FreezeEntityPosition(PlayerPedId(), false)
		exports['mythic_notify']:DoLongHudText('Error', 'Et onnistunut käynnistämään konetta!')
	end)
end)

RegisterNetEvent('Oku_Kuljetusduuni:ToinenKeskustelu')
AddEventHandler('Oku_Kuljetusduuni:ToinenKeskustelu', function()
	SetNuiFocus(false)
    local bossMenu2 = {
        {
            header = "Tässä olis sulle avaimet ja paperiin merkattu kämpän sijainti. Maksan sinulle sitten vähän korvausta!",
            isMenuHeader = true,
        },
        {
            header = "Joo käy toki",
            params = {
				isServer = true,
                event = "Oku_Kuljetusduuni:AnnaAvain",
            }
        },
        {
            header = "Ei kyllä kiinnostakkaan.",
            params = {
				isServer = true,
                event = "",
            }
        },
    }
    exports['qbr-menu']:openMenu(bossMenu2)
end)

local timerCount = 900
local timers = false

RegisterNetEvent('Oku_Kuljetusduuni:GPS')
AddEventHandler('Oku_Kuljetusduuni:GPS', function()
	local blip = Citizen.InvokeNative(0x45f13b7e0a15c880, -1282792512, 2518.42, 2288.6, 177.35, 100.0)
	timers = true
	TriggerEvent("Oku_Kuljetusduuni:Timeri")
	while timers do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local playerdead = IsPlayerDead(playerped)
		if playerdead then
			timers = false
			RemoveBlip(blip)
			break
		end
		if IsPlayerNearCoords2(2518.42, 2288.6, 177.35) then
			RemoveBlip(blip)
			break
		end
		if timerCount == 0 then
			Citizen.Wait(1000)
			RemoveBlip(blip)
			break
		end
	end
end)

AddEventHandler("Oku_Kuljetusduuni:Timeri",function()
	Citizen.CreateThread(function()
		while timers do
			Citizen.Wait(1000)
			if timerCount >= 0 then
				timerCount = timerCount - 1
			else
				timers = false
			end
		end
	end)
end)


function AvaaKeskustelu()
	SetNuiFocus(false)
    local bossMenu = {
        {
            header = "Tipuin tuolta vuoren päältä ja nilkka nyrjähti perkeleen pahasti, voitko hakea asunnoltani tarvikkeita tähän avuksi. Annan sinulle tietenkin korvauksen!",
            isMenuHeader = true,
        },
        {
            header = "Voin auttaa sinua, kerrotko tarkemmat ohjeet.",
            params = {
				isServer = false,
                event = "Oku_Kuljetusduuni:ToinenKeskustelu",
            }
        },
        {
            header = "En nyt kerkeä",
            params = {
				isServer = true,
                event = "",
            }
        },
    }
	speaking = false
    exports['qbr-menu']:openMenu(bossMenu)
end

function SpawnNpcs()
	local paikka = math.random(1,1)
    LoadModel(modeli)
    NpcPed = CreatePed(modeli, paikat[paikka].x, paikat[paikka].y, paikat[paikka].z, paikat[paikka].h, false, true, true, true)
	Citizen.InvokeNative(0x283978A15512B2FE, NpcPed, true)
	FreezeEntityPosition(NpcPed, true)
	SetEntityInvincible(NpcPed, true)
	SetBlockingOfNonTemporaryEvents(NpcPed, true)
	Anim(NpcPed, "veh_train@trolly@exterior@rl@exit@to@land@normal@get_out_start@male","dead_fall_out", -1, 2)
	while true do
		Citizen.Wait(1)

		if IsPlayerNearCoords(paikat[paikka].x, paikat[paikka].y, paikat[paikka].z) then
			if not menu and not missionInProgress then
			   
				local label  = CreateVarString(10, 'LITERAL_STRING', "CrackPot Keksijä") -- TRANSLATE HERE
				PromptSetActiveGroupThisFrame(prompts, label)

				if Citizen.InvokeNative(0xC92AC953F0A982AE,avaaSalaisuus) and not speaking then
					Citizen.Wait(1000)
					speaking = true
					TriggerServerEvent("Oku_Kuljetusduuni:TarkistaAvain")
				end
			end
		end
	end
end

function IsPlayerNearCoords(x, y, z)
    local playerx, playery, playerz = table.unpack(GetEntityCoords(PlayerPedId(), 0))
    local distance = Vdist2(playerx, playery, playerz, x, y, z, true) -- USE VDIST

    if distance < 2 then
        return true
    end
end

function IsPlayerNearCoords2(x, y, z)
    local playerx, playery, playerz = table.unpack(GetEntityCoords(PlayerPedId(), 0))
    local distance = Vdist2(playerx, playery, playerz, x, y, z, true) -- USE VDIST

    if distance < 10000 then
        return true
    end
end

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	DeleteEntity(NpcPed)
	SetEntityAsNoLongerNeeded(NpcPed)	
	RemoveBlip(blip)
end)


function LoadModel(model)
    local model = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
    end
end

function Anim(actor, dict, body, duration, flags, introtiming, exittiming)
	RequestAnimDict(dict)
	local dur = duration or -1
	local flag = flags or 1
	local intro = tonumber(introtiming) or 1.0
	local exit = tonumber(exittiming) or 1.0

	while not HasAnimDictLoaded(dict)  do
		RequestAnimDict(dict)
		Citizen.Wait(300)
	end
	TaskPlayAnim(actor, dict, body, intro, exit, dur, flag, 1, false, false, false, 0, true)
end