local VORPutils = {}

TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)

local ESX = exports['vorp_core']:GetObj()
local isLoggedIn = false
local currentHunger = 0
local currentThirst = 0
local currentalcohol = 0

local playerPed = PlayerPedId()
local stamina = 100
local isOnFoot = false
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

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
    Citizen.CreateThread(function()
		TriggerServerEvent('Perry_Needs:GetData')
    end)
end)
local Dev = false
if Dev then
	Citizen.CreateThread(function()
		TriggerServerEvent('Perry_Needs:GetData')
    end)
end

AddEventHandler('onClientResourceStart', function (resourceName)
  if(GetCurrentResourceName() ~= resourceName) then
    return
  end
  TriggerServerEvent('Perry_Needs:GetData')
end)

function doPromptAnim(dict, anim, loop)
    activate = false
    toggle = 0
    local playerPed = PlayerPedId()
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(playerPed, dict, anim, 8.0, -8.0, 13000, loop, 0, true, 0, false, 0, false)
	play_anim = false
end

RegisterNetEvent("checkcanteenS")
AddEventHandler("checkcanteenS", function()
	if IsEntityInWater(PlayerPedId()) then
		doPromptAnim("amb_work@prop_human_pump_water@female_b@idle_a", "idle_a", 2)
		Wait(10000)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('fillcanteenS')
	else
		ESX.Notify(5, 'Mene veden äärelle täyttääksesi')
	end
end)

RegisterNetEvent('Perry_Needs:UpdateClient')
AddEventHandler('Perry_Needs:UpdateClient', function(hunger, thirst)
	currentHunger = hunger
	currentThirst = thirst
end)

RegisterNetEvent('Perry_Needs:UpdateClientToMeta')
AddEventHandler('Perry_Needs:UpdateClientToMeta', function(metat)
	currentHunger = tonumber(metat.hunger)
	currentThirst = tonumber(metat.thirst)
	isLoggedIn = true
	TriggerServerEvent('Perry_Needs:UpdateNeeds', currentHunger, currentThirst)
end)

RegisterCommand("testneeds", function(source, args, rawCommand)
	local eka = args[1]
	local toka = args[2]
	currentHunger = eka
	currentThirst = toka
	TriggerServerEvent('Perry_Needs:UpdatePlayer', currentHunger, currentThirst)
end)

RegisterNetEvent('Perry_Needs:drink')
AddEventHandler('Perry_Needs:drink', function(objekti, hunger, thirst)
	doPromptAnim(objekti)
	ClearPedTasks(PlayerPedId())
	currentHunger  = currentHunger + hunger
	currentThirst = currentThirst + thirst
	if currentHunger >= 100 then
		currentHunger = 100
	end
	if currentThirst >= 100 then
		currentThirst = 100
	end
	TriggerServerEvent('Perry_Needs:UpdateNeeds', currentHunger, currentThirst)
end)

function doPromptAnim(propName)
	local playerCoords = GetEntityCoords(PlayerPedId(), true, true)
	local dict = "amb_rest_drunk@world_human_drinking@male_a@idle_a"
	local anim = "idle_a"
	if IsPedMale(PlayerPedId()) then
        local dict = "amb_rest_drunk@world_human_drinking@female_a@idle_b"
        local anim = "idle_b"
	end
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
	hashItem = GetHashKey(propName)
	local prop = CreateObject(hashItem, playerCoords.x, playerCoords.y, playerCoords.z + 0.2, true, true, false, false, true)
	local boneIndex = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_R_Finger12")
	TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, 8.0, 5000, 31, 0.0, false, false, false)
	AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.04, 0.018, 0.10, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
	Citizen.Wait(6000)
	DeleteObject(prop)
	ClearPedSecondaryTask(PlayerPedId())
end
	

RegisterNetEvent('Perry_Needs:UseItemOuter')
AddEventHandler('Perry_Needs:UseItemOuter', function(hunger, thirst)
	currentHunger  = currentHunger + hunger
	currentThirst = currentThirst + thirst
	if currentHunger >= 100 then
		currentHunger = 100
	end
	if currentThirst >= 100 then
		currentThirst = 100
	end
	TriggerServerEvent('Perry_Needs:UpdateNeeds', currentHunger, currentThirst)
end)

RegisterNetEvent('Perry_Needs:UseItem')
AddEventHandler('Perry_Needs:UseItem', function(objekti, hunger, thirst, health, stamina)
	Animaatio(objekti)
	currentHunger  = currentHunger + hunger
	currentThirst = currentThirst + thirst
	if currentHunger >= 100 then
		currentHunger = 100
	end
	if currentThirst >= 100 then
		currentThirst = 100
	end
	local playerPed = PlayerPedId()
	local health = GetAttributeCoreValue(playerPed, 0) -- GetAttributeCoreValue (health)
	local newhealth = health + 1
	local stamina = GetAttributeCoreValue(playerPed, 1) --Stamina
	local newstamina = stamina + 4
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
	Citizen.InvokeNative(0xC6258F41D86676E0,playerPed, 0, newhealth) -- SetAttributeCoreValue (health)
	Citizen.InvokeNative(0xC6258F41D86676E0,playerPed, 1, newstamina) -- SetAttributeCoreValue (stamina)
	TriggerServerEvent('Perry_Needs:UpdateNeeds', currentHunger, currentThirst)
end)

function Animaatio(objekti)
	local ped = PlayerPedId()
	local ped_coords = GetEntityCoords(ped)
	local x,y,z =  table.unpack(ped_coords)
	local object = CreateObject(GetHashKey(objekti), x, y, z + 0.2, true, true, true)
	local righthand = GetEntityBoneIndexByName(ped, "SKEL_L_Finger13")
	AttachEntityToEntity(object, ped, righthand, 0.017, -0.01, -0.01, 0.0, 120.0, 10.0, true, true, false, true, 1, true)
	TaskItemInteraction(PlayerPedId(), nil, GetHashKey("EAT_MULTI_BITE_FOOD_SPHERE_D8-2_SANDWICH_QUICK_LEFT_HAND"), true, 0, 0)
	Citizen.Wait(2000)
	ClearPedTasks(PlayerPedId())
	DeleteEntity(object)
end

CreateThread(function()
    while true do
        local sleep = 0
        if isLoggedIn then
			sleep = (1000 * 60) * 4
            TriggerServerEvent('Perry_Needs:UpdatePlayer', currentHunger, currentThirst)
        end
        Wait(sleep)
    end
end)

local endaat = false
local time = 0 

CreateThread(function()
    while true do
        local sleep = 1000
        if playedsound then
			time = time + 1
			if time == 300 then
				time = 0
				playedsound = false
			end
        else
			sleep = 30000
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        if isLoggedIn then
			local ped = PlayerPedId()
			--if (currentHunger <= 15 or currentThirst <= 15) and not IsPedDeadOrDying(ped, 1) then
				--TriggerEvent("vorp:TipBottom", "Mahasi kurnii", 5000)
				--Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "default")
				--Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "dehydrated_unarmed")
				--TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'kurnivamaha', 0.1)
				--Citizen.Wait(30000)
			if (currentHunger <= 5 or currentThirst <= 5) and not IsPedDeadOrDying(ped, 1) then
				local currentHealth = GetEntityHealth(ped)
				local decreaseThreshold = math.random(5, 10)
				local corehealth = GetAttributeCoreValue(ped, 0)
				if corehealth <= 11 then return end --// Checkki ettei nälkäkuolemaa tapahdu
				SetEntityHealth(ped, currentHealth - decreaseThreshold)
			end
        end
        Wait(Config.StatusInterval)
    end
end)

--[[
RegisterCommand('maskii', function()
  TriggerEvent("Perry_Reput:kaasumaski", "gasmask01")
end)]]

RegisterNetEvent('Perry_Reput:kaasumaski') -- Näppäimistö
AddEventHandler('Perry_Reput:kaasumaski', function(maski)	
	if onperkele then 
		Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "default")
		Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "dehydrated_unarmed")
		onperkele = false
		local prop_name = maski
		local playerPed = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
		AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 43676), 0.0, 0.03, -0.05, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
	else
		Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "arthur_healthy")
		Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "default")
		onperkele = true
		DeleteObject(prop)
	end
end)

local ragdoll = false
keys = {
    -- Letter E
    ["U"] = 0xD8F73058,
}
function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

Citizen.CreateThread(function() 
    while true do 
        Citizen.Wait(10)
        if whenKeyJustPressed(keys["U"]) then
            if not ragdoll then 
                ragdoll = true
                SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0) 

            else
                ragdoll = false
            end
            Citizen.Wait(200)
        end  
    end
end) 

Citizen.CreateThread(function() 
    while true do 
        Citizen.Wait(10)
        if ragdoll then 
            ResetPedRagdollTimer(PlayerPedId())
        end
    end
end)

RegisterNetEvent('Perry_Meta:IceCream') 
AddEventHandler('Perry_Meta:IceCream', function(objekti, hunger, thirst)	
	currentHunger  = currentHunger + hunger
	currentThirst = currentThirst + thirst
	if currentHunger >= 100 then
		currentHunger = 100
	end
	if currentThirst >= 100 then
		currentThirst = 100
	end
	TriggerServerEvent('Perry_Needs:UpdateNeeds', currentHunger, currentThirst)
	EatIceCream(objekti)
end)

function EatIceCream(jatski)
	local JatskiPrompt = VORPutils.Prompts:SetupPromptGroup() --Setup Prompt Group
	
	local jatskiprompt = JatskiPrompt:RegisterPrompt("Paina", 0x8AAA0AD4, 1, 1, true, 'hold', {timedeventhash = "MEDIUM_TIMED_EVENT"}) --Register your first prompt
	local ped = PlayerPedId()
	local ped_coords = GetEntityCoords(ped)
	local x,y,z =  table.unpack(ped_coords)
	local objekti = jatski
	local object = CreateObject(GetHashKey(objekti), x, y, z + 0.2, true, true, true)
	local righthand = GetEntityBoneIndexByName(ped, "SKEL_R_Finger13")
	AttachEntityToEntity(object, ped, righthand, -0.01, -0.08, 0.1, 0.0, 160.0, 10.0, true, true, false, true, 1, true)

	RequestAnimDict("mech_inventory@eating@stew")
	while (not HasAnimDictLoaded("mech_inventory@eating@stew")) do
		Citizen.Wait( 100 )
	end
	TaskPlayAnim(PlayerPedId(), "mech_inventory@eating@stew", "eat_trans", 1.0, -1.0, -1, 31, 0, true, 0, false, 0, false)
	
	while true do
		Citizen.Wait(1)
		JatskiPrompt:ShowGroup("Syödäksesi ja X Heittääksesi maahan") --Show your prompt group     
		if IsDisabledControlJustPressed(0, 0x8AAA0AD4) then
			TaskItemInteraction(PlayerPedId(), nil, GetHashKey("EAT_MULTI_BITE_FOOD_SPHERE_D8-2_SANDWICH_QUICK_RIGHT_HAND"), true, 0, 0)
			Citizen.Wait(2000)
			DeleteEntity(object)
			EatIceCream(jatski)
		end
		if IsDisabledControlJustPressed(0, 0x8CC9CD42) then
			DeleteEntity(object)
			ClearPedTasks(ped)
			ClearPedSecondaryTask(ped)
			break
		end
	end
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




----------------OLUET--------------

---- Päivitä saluunaan

RegisterNetEvent('Perry_Meta:Alkoholi')
AddEventHandler('Perry_Meta:Alkoholi', function(item, kasi, sekunda, health, stamina, thirst, alcohol)	
    local playerPed = PlayerPedId()
	local itemi = GetHashKey(item)
	local hand = GetHashKey(kasi)
	local sekonda = GetHashKey(sekunda)
    local propEntity = CreateObject(itemi, GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    local task = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, hand, sekonda, 1, 0, -1.0)
	currentalcohol = currentalcohol + alcohol
	if currentalcohol >= 100 then
		currentalcohol = 100
	end
	local Health = GetAttributeCoreValue(PlayerPedId(), 0)
    local Stamina = GetAttributeCoreValue(PlayerPedId(), 1)
	local newHealth = Health + health
	local newStamina = Stamina + stamina
    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, newHealth) --core
    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, newStamina) --core
    Citizen.InvokeNative(0x50C803A4CD5932C5, true) --core
	currentThirst = currentThirst + thirst
	if currentThirst >= 100 then
		currentThirst = 100
	end
	TriggerServerEvent('Perry_Needs:UpdateNeeds', currentHunger, currentThirst)
end)

local setter = false

CreateThread(function()
    while true do
		local sleep = 0
        if isLoggedIn then
			local ped = PlayerPedId()
			if currentalcohol >= 100 then
				Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "default")
				Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "very_drunk")
				setter = false
			elseif currentalcohol >= 80 then
				Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "default")
				Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "moderate_drunk")
				setter = false
			elseif currentalcohol >= 60 then
				Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "default")
				Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "slightly_drunk")
				setter = false
			elseif currentalcohol >= 40 then
				Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "default")
				Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "slightly_drunk")
				setter = false
			elseif currentalcohol >= 20 then
				setter = false
			else
				if setter == false then
					SetEntityMotionBlur(ped, false)
					Citizen.InvokeNative(0x923583741DC87BCE, ped, "arthur_healthy")
					setter = true
				end
			end
			sleep = 5000
        end
        Citizen.Wait(sleep)
    end
end)

