ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local playerPed = PlayerPedId()
local stamina = 100
local isOnFoot = true
local isRagdolling = false
local ragdollStart
local ragdollLastDamagedBone
local ragdollMaxZ
local ragdollLastZ = 0
local ragdollDidDamage = false
local canRagdollWithKey = true

local desiredMaxBlendRatio = 3.0
local boneSpeedLimit = 3.0
local warmthSpeedLimit = 3.0

local InvokeNative = Citizen.InvokeNative

local InputJump = GetHashKey('INPUT_JUMP')
local InputSniperZoomInOnly = GetHashKey('INPUT_SNIPER_ZOOM_IN_ONLY')
local InputSniperZoomOutOnly = GetHashKey('INPUT_SNIPER_ZOOM_OUT_ONLY')
local InputFrontendRs = GetHashKey('INPUT_FRONTEND_RS')

local min, max, ceil, abs = math.min, math.max, math.ceil, math.abs

function clamp(value, min, max)
    if value < min then
        return min
    elseif value > max then
        return max
    else
        return value
    end
end

function lerp(a, b, t) return a * (1 - t) + b * t end
function LoadTexture(dict)
    if Citizen.InvokeNative(0x7332461FC59EB7EC, dict) then
        RequestStreamedTextureDict(dict, true)
        while not HasStreamedTextureDictLoaded(dict) do
            Wait(1)
        end
        return true
    else
        return false
    end
end

local ESX = exports['vorp_core']:GetObj()

RegisterNetEvent('hospital:client:ambulanceAlert', function(coords, text, sender)
	ESX.Notify(5, 'Apua tarvitaan - ['..sender..']')


    local transG = 10

    local blip = N_0x554d9d53f696d002(1664425300, coords.x, coords.y, coords.z) --AddBlip
    SetBlipSprite(blip, 960467426, 1)
    SetBlipScale(blip, 0.2)
    Citizen.InvokeNative(0x662D364ABF16DE2F, blip, `BLIP_MODIFIER_MP_COLOR_8`)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Tarvitaan apua') --SetBlipName
    while transG ~= 0 do
        Wait(60000 * 1)
        transG = transG - 1
        if transG <= 0 then
            RemoveBlip(blip)
            return
        end
    end
end)


RegisterNetEvent('checkdeathcause', function() 
    local DoctorPed = GetPlayerPed(PlayerId())
    local closePlayer = GetClosestPlayer(DoctorPed)
    local closePed = GetPlayerPed(closePlayer)
    if IsPedDeadOrDying(closePed, 1) then
		local id = GetPlayerServerId(closePlayer)
		TriggerServerEvent("getdeathcause", id)
	end
end)

RegisterNetEvent('checkdamage', function() 
    local DoctorPed = GetPlayerPed(PlayerId())
    local closePlayer = GetClosestPlayer(DoctorPed)
    local closePed = GetPlayerPed(closePlayer)
    if IsPedDeadOrDying(closePed, 1) then
		local id = GetPlayerServerId(closePlayer)
		TriggerServerEvent("getdamagepoints", id)
	end
end)

RegisterNetEvent('healplayer', function() 
	TriggerServerEvent("getbandage")
end)

RegisterNetEvent('healself', function() 
	local ped = PlayerPedId()
	local animdic = "mini_games@story@mob4@heal_jules@bandage@arthur"
	local anim = "bandage_fast"
	RequestAnimDict(animdic)
	while not HasAnimDictLoaded(animdic) do
		Citizen.Wait(100)
	end
	TaskPlayAnim(PlayerPedId(), animdic, anim, 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
	Wait(2000)
	local outerhealth = GetEntityHealth(ped)
	local corehealth = GetAttributeCoreValue(ped, 0) -- GetAttributeCoreValue (health)
	local corenewhealth = corehealth + 50
	local corestamina = GetAttributeCoreValue(ped, 1) --Stamina
	local corenewstamina = corestamina + 20

	Citizen.InvokeNative(0xC6258F41D86676E0,ped, 0, corenewhealth) -- SetAttributeCoreValue (health)
	Citizen.InvokeNative(0xC6258F41D86676E0,ped, 1, corenewstamina) -- SetAttributeCoreValue (stamina)
	SetEntityHealth(ped, GetEntityMaxHealth(ped)) -- outter after

end)

RegisterNetEvent('healclosest', function() 
	local DoctorPed = GetPlayerPed(PlayerId())
    local closePlayer = GetClosestPlayer(DoctorPed)
    local closePed = GetPlayerPed(closePlayer)
	local animdic = "mini_games@story@mob4@heal_jules@bandage@arthur"
	local anim = "bandage_fast"
	RequestAnimDict(animdic)
	while not HasAnimDictLoaded(animdic) do
		Citizen.Wait(100)
	end
	TaskPlayAnim(PlayerPedId(), animdic, anim, 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
	Wait(2000)
	local currenthealth = GetEntityHealth(closePed)
	print(currenthealth)
	if currenthealth >= 75 then
		Citizen.InvokeNative(0xC6258F41D86676E0, closePed, 0, 100) -- inner first
		SetEntityHealth(ped, 100, 1) -- outter after
		Citizen.InvokeNative(0xC6258F41D86676E0, closePed, 1, 100) -- only fills inner
		Citizen.InvokeNative(0x675680D089BFA21F, closePed, 1065330373) -- only fills outter with a weird amount of numbers
	else
		Citizen.InvokeNative(0xC6258F41D86676E0, closePed, 0, fullhealth) -- inner first
		SetEntityHealth(ped, 100, 1) -- outter after
		Citizen.InvokeNative(0xC6258F41D86676E0, closePed, 1, fullhealth) -- only fills inner
		Citizen.InvokeNative(0x675680D089BFA21F, closePed, 1065330373) -- only fills outter with a weird amount of numbers
	end
end)

--[[
HealPlayer = function()
    local ped = PlayerPedId()
    Citizen.InvokeNative(0xC6258F41D86676E0, ped, 0, 100) -- inner first
    SetEntityHealth(ped, 100, 1) -- outter after
    Citizen.InvokeNative(0xC6258F41D86676E0, ped, 1, 100) -- only fills inner
    Citizen.InvokeNative(0x675680D089BFA21F, ped, 1065330373) -- only fills outter with a weird amount of numbers
    --TriggerEvent("vorpmetabolism:setValue", "Thirst", 1000) -- metabolism
    -- TriggerEvent("vorpmetabolism:setValue", "Hunger", 1000)
end
--]]

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end


RegisterNetEvent('clientsenddamagepoints', function(table) 
    local DoctorPed = GetPlayerPed(PlayerId())
    local closePlayer = GetClosestPlayer(DoctorPed)
    local closePed = GetPlayerPed(closePlayer)
	local tabletti = json.decode(table)
	for i,v in pairs(tabletti) do
		local bones = v.bones
		local bonecoords = GetPedBoneCoords(closePed, bones)
		if bones then
			Notification(bonecoords.x, bonecoords.y, bonecoords.z)
			Wait(5000)
			break
		else
			TriggerEvent("vorp:TipBottom", "Ei saatu selville!", 5000)
		end
	end
end)

RegisterNetEvent('reviveplayer', function() 
	TriggerServerEvent("getitemstorevive")
end)

RegisterNetEvent('revivesystem', function(item) 
    local DoctorPed = GetPlayerPed(PlayerId())
    local closePlayer = GetClosestPlayer(DoctorPed)
    local closePed = GetPlayerPed(closePlayer)
	local finished = exports["tgiann-skillbar"]:taskBar(2000)
    if not finished then
		ClearPedTasks(PlayerPedId())
		ClearPedSecondaryTask(PlayerPedId())
		TriggerServerEvent("givebackitem" , item, 1)
		TriggerEvent("vorp:TipBottom", "Epäonnistuit", 5000)
	else
		local finished = exports["tgiann-skillbar"]:taskBar(2000)
		if not finished then
			ClearPedTasks(PlayerPedId())
			ClearPedSecondaryTask(PlayerPedId())
			TriggerServerEvent("givebackitem" , item, 1)
			TriggerEvent("vorp:TipBottom", "Epäonnistuit", 5000)
		else
			local finished = exports["tgiann-skillbar"]:taskBar(3200)
			if not finished then
				ClearPedTasks(PlayerPedId())
				ClearPedSecondaryTask(PlayerPedId())
				TriggerServerEvent("givebackitem" , item, 1)
				TriggerEvent("vorp:TipBottom", "Epäonnistuit", 5000)
			else
				local finished = exports["tgiann-skillbar"]:taskBar(4500)
				if not finished then
					ClearPedTasks(PlayerPedId())
					ClearPedSecondaryTask(PlayerPedId())
					TriggerServerEvent("givebackitem" , item, 1)
					TriggerEvent("vorp:TipBottom", "Epäonnistuit", 5000)
				else
					ClearPedTasks(PlayerPedId())
					ClearPedSecondaryTask(PlayerPedId())
					Citizen.Wait(3000)
					local id = GetPlayerServerId(closePlayer)
					PlayAnim(PlayerPedId(), "mech_revive@unapproved", "revive") --change
					Citizen.Wait(5000)
					TriggerServerEvent("resurrectPlayer", id)
				end
			end
		end
	end
end)

RegisterNetEvent('GoOnTheGround', function() 
	TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_SLEEP_GROUND_ARM'), -1, false, "test", 0, false)  
end)

function PlayAnim(ped, dict, anim)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
    end

    while not HasAnimDictLoaded(dict) do
        Wait(500)
    end

    FreezeEntityPosition(ped, true)

    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)

    FreezeEntityPosition(ped, false)
end

function Notification(x,y,z)
	local timestamp = GetGameTimer()

	while (timestamp + 8000) > GetGameTimer() do
		Citizen.Wait(0)
		DrawText3D(x, y, z, 'X', 0.1)
	end
end

RegisterNetEvent('clientsenddeathTable', function(table, job) 
	TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_PLAYER_CAMP_FIRE_SQUAT'), 10, true, true, false, false)
	local tabletti = json.decode(table)
	for i,v in pairs(tabletti) do
		SetNuiFocus(false)
		if job == "medic" then
			if v.damagetype == "melee" then
				local bossMenu = {
					{
						header = "Henkilöä on puukotettu, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Kyllä",
						params = {
							isServer = false,
							event = "reviveplayer",
						}
					},
					{
						header = "En",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "fire" then
				local bossMenu = {
					{
						header = "Henkilö on palanut, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Kyllä",
						params = {
							isServer = false,
							event = "reviveplayer",
						}
					},
					{
						header = "En",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "revolver" then
				local bossMenu = {
					{
						header = "Henkilö on ammuttu revolverilla, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Kyllä",
						params = {
							isServer = false,
							event = "reviveplayer",
						}
					},
					{
						header = "En",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "pistol" then
				local bossMenu = {
					{
						header = "Henkilö on ammuttu pistoolilla, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Kyllä",
						params = {
							isServer = false,
							event = "reviveplayer",
						}
					},
					{
						header = "En",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "repeater" then
				local bossMenu = {
					{
						header = "Henkilö on ammuttu vipulukolla, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Kyllä",
						params = {
							isServer = false,
							event = "reviveplayer",
						}
					},
					{
						header = "En",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "rifle" then
				local bossMenu = {
					{
						header = "Henkilö on ammuttu kiväärillä, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Kyllä",
						params = {
							isServer = false,
							event = "reviveplayer",
						}
					},
					{
						header = "En",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "shotgun" then
				local bossMenu = {
					{
						header = "Henkilö on ammuttu haulikolla, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Kyllä",
						params = {
							isServer = false,
							event = "reviveplayer",
						}
					},
					{
						header = "En",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "sniper" then
				local bossMenu = {
					{
						header = "Henkilö on ammuttu tarkkuuskiväärillä, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Kyllä",
						params = {
							isServer = false,
							event = "reviveplayer",
						}
					},
					{
						header = "En",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "bomb" then
				local bossMenu = {
					{
						header = "Henkilö on ollut räjähdyksen lähellä, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Kyllä",
						params = {
							isServer = false,
							event = "reviveplayer",
						}
					},
					{
						header = "En",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "horse" then
				local bossMenu = {
					{
						header = "Henkilöä on selvästi potkaissut hevonen, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Kyllä",
						params = {
							isServer = false,
							event = "reviveplayer",
						}
					},
					{
						header = "En",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "snake" then
				local bossMenu = {
					{
						header = "Henkilöä on purrut käärme, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Kyllä",
						params = {
							isServer = false,
							event = "reviveplayer",
						}
					},
					{
						header = "En",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "falldamage" then
				local bossMenu = {
					{
						header = "Henkilö on pudonnut korkealta, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Kyllä",
						params = {
							isServer = false,
							event = "reviveplayer",
						}
					},
					{
						header = "En",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "bear" then
				local bossMenu = {
					{
						header = "Henkilöä on raapaissut karhu, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Kyllä",
						params = {
							isServer = false,
							event = "reviveplayer",
						}
					},
					{
						header = "En",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "wolf" then
				local bossMenu = {
					{
						header = "Henkilöä on raapaissut susi, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Kyllä",
						params = {
							isServer = false,
							event = "reviveplayer",
						}
					},
					{
						header = "En",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "unknown" then
				local bossMenu = {
					{
						header = "Henkilö on tajuton tuntemattomasta syystä, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Kyllä",
						params = {
							isServer = false,
							event = "reviveplayer",
						}
					},
					{
						header = "En",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			end
		
		else
			if v.damagetype == "melee" then
				local bossMenu = {
					{
						header = "Henkilössä on viiltoja kehossa",
						isMenuHeader = true,
					},
					{
						header = "Poistu",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "fire" then
				local bossMenu = {
					{
						header = "Henkilö on selvästi palanut, kehossa useita palovammoja",
						isMenuHeader = true,
					},
					{
						header = "Poistu",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "rifle" or v.damagetype == "pistol" or v.damagetype == "repeater" or v.damagetype == "revolver" or v.damagetype == "sniper" then
				local bossMenu = {
					{
						header = "Henkilö on ammuttu jonkinsortin aseella",
						isMenuHeader = true,
					},
					{
						header = "Poistu",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "shotgun" then
				local bossMenu = {
					{
						header = "Henkilössä on useita pieniä haavoja",
						isMenuHeader = true,
					},
					{
						header = "Poistu",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "bomb" then
				local bossMenu = {
					{
						header = "Henkilöllä on useita ruhjeita kehossa.",
						isMenuHeader = true,
					},
					{
						header = "Poistu",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "horse" then
				local bossMenu = {
					{
						header = "Näyttäisi että henkilöä on potkaissut hevonen, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Kyllä",
						params = {
							isServer = false,
							event = "reviveplayer",
						}
					},
					{
						header = "En",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "snake" then
				local bossMenu = {
					{
						header = "Henkilöä on purrut käärme",
						isMenuHeader = true,
					},
					{
						header = "Poistu",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "falldamage" then
				local bossMenu = {
					{
						header = "Henkilö on pudonnut korkealta",
						isMenuHeader = true,
					},
					{
						header = "Poistu",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "bear" then
				local bossMenu = {
					{
						header = "Henkilöä on raapaissut joku kookkaampi eläin, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Poistu",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "wolf" then
				local bossMenu = {
					{
						header = "Henkilöä on raapaissut joku eläin, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Poistu",
						params = {
							isServer = false,
							event = "",
						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			elseif v.damagetype == "unknown" then
				local bossMenu = {
					{
						header = "En tiedä mitä henkilölle on tapahtunut, haluatko auttaa?",
						isMenuHeader = true,
					},
					{
						header = "Kyllä",
						params = {
							isServer = false,
							event = "reviveplayer",
						}
					},
					{
						header = "En",
						params = {
							isServer = false,
							event = "",

						}
					},
				}
				exports['qbr-menu']:openMenu(bossMenu)
			end
		end
	end
end)


CreateThread(function()
    while true do
        Wait(1)
        DisableControlAction(0, 0x62800C92)
        DisableControlAction(0, 0x8BDE7443)	
			Citizen.InvokeNative(0x8BC7C1F929D07BF3, 2011163970)
			Citizen.InvokeNative(0x8BC7C1F929D07BF3, -1249243147)
			Citizen.InvokeNative(0x8BC7C1F929D07BF3, -2106452847)
        if IsDisabledControlJustReleased(0,0x62800C92) or IsDisabledControlJustReleased(0,0x8BDE7443) then
			Citizen.InvokeNative(0x4CC5F2FC1332577F, 2011163970)
			Citizen.InvokeNative(0x4CC5F2FC1332577F, -1249243147)
			Citizen.InvokeNative(0x4CC5F2FC1332577F, -2106452847)
        end
    end
end)

RegisterCommand('die', function()
	SetEntityHealth(PlayerPedId(), 0)
end)

CreateThread(function()
    while true do
        Wait(200)
        if ragdoll then
            Citizen.InvokeNative(0xC1E8A365BF3B29F2,PlayerPedId(),225,true)
        else
            Citizen.InvokeNative(0xC1E8A365BF3B29F2,PlayerPedId(),225,false)
        end
    end
end)

CreateThread(function()
    while true do
        sleep = 1000
		local DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())	
		if IsPedDeadOrDying(PlayerPedId(), 1) then
			if IsMelee(DeathCauseHash) then
				local bone
				local success = GetPedLastDamageBone(PlayerPedId(),bone)
				local success,bone = GetPedLastDamageBone(PlayerPedId())
				if success then
					TriggerServerEvent('eventDeath', "melee", bone)
					ClearPedLastDamageBone(PlayerPedId())
				end
			elseif IsFire(DeathCauseHash) then
				local bone
				local success = GetPedLastDamageBone(PlayerPedId(),bone)
				local success,bone = GetPedLastDamageBone(PlayerPedId())
				if success then
					TriggerServerEvent('eventDeath', "fire", bone)
					ClearPedLastDamageBone(PlayerPedId())
				end
			elseif IsRevolver(DeathCauseHash) then
				local bone
				local success = GetPedLastDamageBone(PlayerPedId(),bone)
				local success,bone = GetPedLastDamageBone(PlayerPedId())
				if success then
					TriggerServerEvent('eventDeath', "revolver", bone)
					ClearPedLastDamageBone(PlayerPedId())
				end
			elseif IsPistol(DeathCauseHash) then
				local bone
				local success = GetPedLastDamageBone(PlayerPedId(),bone)
				local success,bone = GetPedLastDamageBone(PlayerPedId())
				if success then
					TriggerServerEvent('eventDeath', "pistol", bone)
					ClearPedLastDamageBone(PlayerPedId())
				end
			elseif IsRepeater(DeathCauseHash) then
				local bone
				local success = GetPedLastDamageBone(PlayerPedId(),bone)
				local success,bone = GetPedLastDamageBone(PlayerPedId())
				if success then
					TriggerServerEvent('eventDeath', "repeater", bone)
					ClearPedLastDamageBone(PlayerPedId())
				end
			elseif IsRifle(DeathCauseHash) then
				local bone
				local success = GetPedLastDamageBone(PlayerPedId(),bone)
				local success,bone = GetPedLastDamageBone(PlayerPedId())
				if success then
					TriggerServerEvent('eventDeath', "rifle", bone)
					ClearPedLastDamageBone(PlayerPedId())
				end
			elseif IsShotgun(DeathCauseHash) then
				local bone
				local success = GetPedLastDamageBone(PlayerPedId(),bone)
				local success,bone = GetPedLastDamageBone(PlayerPedId())
				if success then
					TriggerServerEvent('eventDeath', "shotgun", bone)
					ClearPedLastDamageBone(PlayerPedId())
				end
			elseif IsSniper(DeathCauseHash) then
				local bone
				local success = GetPedLastDamageBone(PlayerPedId(),bone)
				local success,bone = GetPedLastDamageBone(PlayerPedId())
				if success then
					TriggerServerEvent('eventDeath', "falldamage", bone)
					ClearPedLastDamageBone(PlayerPedId())
				end
			elseif IsBomb(DeathCauseHash) then
				local bone
				local success = GetPedLastDamageBone(PlayerPedId(),bone)
				local success,bone = GetPedLastDamageBone(PlayerPedId())
				if success then
					TriggerServerEvent('eventDeath', "falldamage", bone)
					ClearPedLastDamageBone(PlayerPedId())
				end
			elseif DeathCauseHash == -1949138268 then
				local bone
				local success = GetPedLastDamageBone(PlayerPedId(),bone)
				local success,bone = GetPedLastDamageBone(PlayerPedId())
				if success then
					TriggerServerEvent('eventDeath', "horse", bone)
					ClearPedLastDamageBone(PlayerPedId())
				end
			elseif DeathCauseHash == -655377385 then
				local bone
				local success = GetPedLastDamageBone(PlayerPedId(),bone)
				local success,bone = GetPedLastDamageBone(PlayerPedId())
				if success then
					TriggerServerEvent('eventDeath', "snake", bone)
					ClearPedLastDamageBone(PlayerPedId())
				end
			elseif DeathCauseHash == -842959696 then
				local bone
				local success = GetPedLastDamageBone(PlayerPedId(),bone)
				local success,bone = GetPedLastDamageBone(PlayerPedId())
				if success then
					TriggerServerEvent('eventDeath', "falldamage", bone)
					ClearPedLastDamageBone(PlayerPedId())
				end
			elseif DeathCauseHash == -515998169 then
				local bone
				local success = GetPedLastDamageBone(PlayerPedId(),bone)
				local success,bone = GetPedLastDamageBone(PlayerPedId())
				if success then
					TriggerServerEvent('eventDeath', "bear", bone)
					ClearPedLastDamageBone(PlayerPedId())
				end
			elseif DeathCauseHash == 37266233 then
				local bone
				local success = GetPedLastDamageBone(PlayerPedId(),bone)
				local success,bone = GetPedLastDamageBone(PlayerPedId())
				if success then
					TriggerServerEvent('eventDeath', "wolf", bone)
					ClearPedLastDamageBone(PlayerPedId())
				end
			else
				local bone
				local success = GetPedLastDamageBone(PlayerPedId(),bone)
				local success,bone = GetPedLastDamageBone(PlayerPedId())
				if success then
					TriggerServerEvent('eventDeath', "unknown", bone)
					ClearPedLastDamageBone(PlayerPedId())
				end
			end
		end
        Wait(sleep)
    end
end)


function Notification(x,y,z)
	local timestamp = GetGameTimer()

	while (timestamp + 2500) > GetGameTimer() do
		Citizen.Wait(0)
		DrawText3D(x, y, z, 'X')
	end
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())  
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    if onScreen then
    	SetTextScale(0.30, 0.30)
  		SetTextFontForCurrentCommand(1)
    	SetTextColor(255, 0, 0, 215)
    	SetTextCentre(1)
    	DisplayText(str,_x,_y)
    	local factor = (string.len(text)) / 225
    	--DrawSprite("feeds", "toast_bg", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
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

function IsMelee(Weapon)
	local Weapons = {   
	'weapon_melee_hatchet',
    'weapon_melee_hatchet_hunter',
    'weapon_thrown_tomahawk_ancient',
    'weapon_thrown_tomahawk',
    'weapon_melee_hatchet_double_bit',
    'weapon_thrown_throwing_knives',
    'weapon_melee_cleaver',
    'weapon_melee_machete_horror',
    'weapon_melee_knife_trader',
    'weapon_melee_machete_collector',
    'weapon_melee_knife_horror',
    'weapon_melee_knife_rustic',
	}

	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsFire(Weapon)
	local Weapons = {
	'WEAPON_THROWN_MOLOTOV',
	'weapon_moonshinejug_mp',
	}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsRevolver(Weapon)
	local Weapons = {
	'weapon_revolver_doubleaction',
    'weapon_revolver_cattleman',
    'weapon_revolver_cattleman_mexican',
    'weapon_revolver_lemat',
    'weapon_revolver_schofield',
    'weapon_revolver_doubleaction_gambler',
	}

	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsPistol(Weapon)
	local Weapons = {
	'weapon_pistol_volcanic',
    'weapon_pistol_m1899',
    'weapon_pistol_semiauto',
    'weapon_pistol_mauser',
	}

	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsRepeater(Weapon)
	local Weapons = {    
	'weapon_repeater_evans',
    'weapon_repeater_henry',
    'weapon_repeater_winchester',
    'weapon_repeater_carbine',
	}

	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsRifle(Weapon)
	local Weapons = {    
	'weapon_rifle_springfield',
    'weapon_rifle_boltaction',
    'weapon_rifle_varmint',
	}

	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsShotgun(Weapon)
	local Weapons = {    
	'weapon_shotgun_sawedoff',
    'weapon_shotgun_doublebarrel_exotic',
    'weapon_shotgun_pump',
    'weapon_shotgun_repeating',
    'weapon_shotgun_semiauto',
    'weapon_shotgun_doublebarrel',
	}

	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsSniper(Weapon)
	local Weapons = {    
	'weapon_sniperrifle_carcano',
    'weapon_sniperrifle_rollingblock',
	}

	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsBomb(Weapon)
	local Weapons = {'weapon_thrown_dynamite'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end