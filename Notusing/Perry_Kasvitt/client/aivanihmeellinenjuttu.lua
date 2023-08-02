local active = false
local isPicking = false
local peyoteCooldownSeconds = 1800
local ginsengCooldownSeconds = 180
local mushroomCooldownSeconds = 180
local cooldownSecondsRemaining = 0
local PickPrompt
local forced = false

local function loadModel(model)
    if not HasModelLoaded(model) then
        RequestModel(model)
    end
    while not HasModelLoaded(model) do
        Wait(10)
    end
end

local function handlePeyote()
    cooldownSecondsRemaining = peyoteCooldownSeconds
    Citizen.CreateThread(function()
        while cooldownSecondsRemaining > 0 do
            Citizen.Wait(1000)
            cooldownSecondsRemaining = cooldownSecondsRemaining - 1
        end
    end)
end

local function handleGinseng()
    cooldownSecondsRemaining = ginsengCooldownSeconds
    Citizen.CreateThread(function()
        while cooldownSecondsRemaining > 0 do
            Citizen.Wait(1000)
            cooldownSecondsRemaining = cooldownSecondsRemaining - 1
        end
    end)
end

local function handleMushroom()
    cooldownSecondsRemaining = mushroomCooldownSeconds
    Citizen.CreateThread(function()
        while cooldownSecondsRemaining > 0 do
            Citizen.Wait(1000)
            cooldownSecondsRemaining = cooldownSecondsRemaining - 1
        end
    end)
end

local function SetupPickPrompt()
    Citizen.CreateThread(function()
        local str = 'Ota kasvi'
        PickPrompt = PromptRegisterBegin()
        PromptSetControlAction(PickPrompt, 0xF84FA74F)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(PickPrompt, str)
        PromptSetEnabled(PickPrompt, false)
        PromptSetVisible(PickPrompt, false)
        PromptSetHoldMode(PickPrompt, true)
        PromptRegisterEnd(PickPrompt)
    end)
end

local function Blink()
    DoScreenFadeOut(500)    
    Wait(500)
    DoScreenFadeIn(500)
    Wait(500)
end

local function handleVision()
    Blink()
    Wait(10000)
    Blink()
    Wait(10000)
    Blink()
    Wait(10000)
    Blink()
    Wait(10000)
    Blink()
    Wait(10000)
    Blink()
    Wait(10000)
    Blink()
    Wait(10000)
    Blink()
    Wait(10000)
    Blink()
    Wait(10000)
    Blink()
    Wait(10000)
    Blink()
    Wait(10000)
end

local function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
end

RegisterNetEvent('Perry_Kasvit:eatPeyote')
AddEventHandler('Perry_Kasvit:eatPeyote', function()

    local playerPed = PlayerPedId()
    loadAnimDict("mech_pickup@food@nuts@bar")
    HidePedWeaponForScriptedCutscene(playerPed, true)
    TaskPlayAnim(playerPed, "mech_pickup@food@nuts@bar", "lh_base", 8.0, -8.0, 4000, 31, 0, true, 0, false, 0, false)
    FreezeEntityPosition(playerPed, true)
    Citizen.Wait(5000)
    ClearPedTasks(playerPed)
    FreezeEntityPosition(playerPed, false)
    RemoveAnimDict("mech_pickup@food@nuts@bar")
    Citizen.InvokeNative(0xAE99FB955581844A, playerPed, 10000, 10000, 0, 0, 0, 0)
    DoScreenFadeOut(3000)    
    Wait(3000)
    --TriggerEvent('InteractSound_CL:PlayOnOne', 'peyote', 0.1)
    SetEntityCoords(PlayerPedId(), 174.93, 1828.911, 201.23)
    Citizen.InvokeNative(0xF6A7C08DF2E28B28, playerPed, 0, 2000.0)
    Citizen.InvokeNative(0xF6A7C08DF2E28B28, playerPed, 1, 2000.0)
    EnableAttributeOverpower(playerPed, 0, 2000.0)
    EnableAttributeOverpower(playerPed, 1, 2000.0)
    local tripped = Config.peds[math.random(#Config.peds)]
    local pedtochange = GetHashKey(tripped)
    if not HasModelLoaded(pedtochange) then end
    RequestModel(pedtochange)
    while not HasModelLoaded(pedtochange) do
        Wait(1)
        Citizen.InvokeNative(0xFA28FE3A6246FC30, pedtochange, true)
    end
    Citizen.InvokeNative(0xED40380076A31506, PlayerId(), pedtochange, 1)
	Citizen.InvokeNative(0x4102732DF6B4005F, "PlayerDrugsHalluc01", 0, true)
    Wait(8000)
    DoScreenFadeIn(5000)
    Wait(5000)
    ClearPedTasks(playerPed)
    handleVision()
    Citizen.InvokeNative(0xAE99FB955581844A, playerPed, 10000, 10000, 0, 0, 0, 0)
    DoScreenFadeOut(5000)    
    Wait(5000)
    ExecuteCommand('rc')
    Citizen.InvokeNative(0xF6A7C08DF2E28B28, playerPed, 0, 0.0)
    Citizen.InvokeNative(0xF6A7C08DF2E28B28, playerPed, 1, 0.0)
    EnableAttributeOverpower(playerPed, 0, 0.0)
    EnableAttributeOverpower(playerPed, 1, 0.0)
    if Citizen.InvokeNative(0x4A123E85D7C4CA0B,"PlayerDrugsHalluc01") then 
		Citizen.InvokeNative(0xB4FD7446BAB2F394,"PlayerDrugsHalluc01")
	end
	SetEntityCoords(PlayerPedId(), -381.00, 739.788, 116.60)
    Wait(4000)
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_SLEEP_GROUND_ARM'), -1, false, "test", 0, false)
    Wait(4000)
    DoScreenFadeIn(5000)
    Wait(5000)
    ExecuteCommand('c')

end)

RegisterNetEvent('Perry_Kasvit:eatGinseng')
AddEventHandler('Perry_Kasvit:eatGinseng', function()

    local playerPed = PlayerPedId()
    loadAnimDict("mech_pickup@food@nuts@bar")
    HidePedWeaponForScriptedCutscene(playerPed, true)
    TaskPlayAnim(playerPed, "mech_pickup@food@nuts@bar", "lh_base", 8.0, -8.0, 4000, 31, 0, true, 0, false, 0, false)
    FreezeEntityPosition(playerPed, true)
    Citizen.Wait(5000)
    ClearPedTasks(playerPed)
    FreezeEntityPosition(playerPed, false)
    RemoveAnimDict("mech_pickup@food@nuts@bar")
    Citizen.InvokeNative(0xFA08722A5EA82DA7, 'LensDistDrunk')
    Citizen.InvokeNative(0xFDB74C9CC54C3F37, 0.5)
    Citizen.InvokeNative(0xF6A7C08DF2E28B28, playerPed, 1, 200.0)
    EnableAttributeOverpower(playerPed, 1, 1000.0)
    Wait(300000)
    ClearTimecycleModifier()

end)

RegisterNetEvent('Perry_Kasvit:eatMushroom')
AddEventHandler('Perry_Kasvit:eatMushroom', function()

    local playerPed = PlayerPedId()
    loadAnimDict("mech_pickup@food@nuts@bar")
    HidePedWeaponForScriptedCutscene(playerPed, true)
    TaskPlayAnim(playerPed, "mech_pickup@food@nuts@bar", "lh_base", 8.0, -8.0, 4000, 31, 0, true, 0, false, 0, false)
    FreezeEntityPosition(playerPed, true)
    Citizen.Wait(5000)
    ClearPedTasks(playerPed)
    FreezeEntityPosition(playerPed, false)
    RemoveAnimDict("mech_pickup@food@nuts@bar")
	Citizen.InvokeNative(0x4102732DF6B4005F, "PlayerDrugsHalluc01", 0, true)
    Citizen.InvokeNative(0xF6A7C08DF2E28B28, playerPed, 1, 1000.0)
    EnableAttributeOverpower(playerPed, 1, 1000.0)
    Wait(300000)
	if Citizen.InvokeNative(0x4A123E85D7C4CA0B,"PlayerDrugsHalluc01") then 
		Citizen.InvokeNative(0xB4FD7446BAB2F394,"PlayerDrugsHalluc01")
	end
    
end)

local function FullRequest(thing, dtype)
    if dtype == "anim" then
        RequestAnimDict(thing)
        while not HasAnimDictLoaded(thing) do
            Citizen.Wait(200)
        end
    end

end

RegisterNetEvent('Perry_Kasvit:startPeyote')
AddEventHandler('Perry_Kasvit:startPeyote', function()

	local playerPed = PlayerPedId()
    local playerPed = PlayerPedId()
    local dict = "amb_work@world_human_farmer_weeding@male_a@idle_b"
    local anim = "idle_e"
    FullRequest(dict, "anim")
    TaskPlayAnim(playerPed, dict, anim, 0.5, -10.0, 15000, 1, 0, true, 0, false, 0, false) 
    exports['progressBars']:startUI(15000, "Yritetään varovasti nostaa kasvia...")
    Wait(15000)
    
    if cooldownSecondsRemaining <= 0 then
        TriggerServerEvent('Perry_Kasvit:pickPeyote')
        handlePeyote()
    else
		TriggerEvent('vorp:TipBottom', "Kasvi hajosi käsiisi", 4000) 
    end
    Wait(1000)
    ClearPedTasks(playerPed)
    RemoveAnimDict('amb_work@world_human_farmer_weeding@male_a@idle_b')
    isPicking = false

end)

RegisterNetEvent('Perry_Kasvit:startGinseng')
AddEventHandler('Perry_Kasvit:startGinseng', function()

    local playerPed = PlayerPedId()
    local playerPed = PlayerPedId()
    local dict = "amb_work@world_human_farmer_weeding@male_a@idle_b"
    local anim = "idle_e"
    FullRequest(dict, "anim")
    TaskPlayAnim(playerPed, dict, anim, 0.5, -10.0, 15000, 1, 0, true, 0, false, 0, false) 
    exports['progressBars']:startUI(15000, "Yritetään varovasti nostaa kasvia...")
    Wait(15000)

    if cooldownSecondsRemaining <= 0 then
        TriggerServerEvent('Perry_Kasvit:pickGinseng')
        handleGinseng()
    else
        TriggerEvent('vorp:TipBottom', "Kasvi hajosi käsiisi", 4000) 
    end
    Wait(1000)
    ClearPedTasks(playerPed)
    isPicking = false
	
end)

RegisterNetEvent('Perry_Kasvit:startMushroom')
AddEventHandler('Perry_Kasvit:startMushroom', function()

    local playerPed = PlayerPedId()
    local playerPed = PlayerPedId()
    local dict = "amb_work@world_human_farmer_weeding@male_a@idle_b"
    local anim = "idle_e"
    FullRequest(dict, "anim")
    TaskPlayAnim(playerPed, dict, anim, 0.5, -10.0, 15000, 1, 0, true, 0, false, 0, false) 
    exports['progressBars']:startUI(15000, "Yritetään varovasti nostaa kasvia...")
    Wait(15000)

    if cooldownSecondsRemaining <= 0 then
        TriggerServerEvent('Perry_Kasvit:pickMushroom')
        handleMushroom()
    else
        TriggerEvent('vorp:TipBottom', "Kasvi hajosi käsiisi", 4000) 
    end
    Wait(1000)
    ClearPedTasks(playerPed)
    isPicking = false
	
end)

Citizen.CreateThread(function()
    SetupPickPrompt()
    for k,v in pairs(Config.Peyote) do
        local modelHash = `S_INV_ORCHID_LNIGHT_01BX`
        loadModel(modelHash)
        obj = CreateObject(modelHash, v.x, v.y, v.z-1.0, true, true, true)
        PlaceObjectOnGroundProperly(obj)
        FreezeEntityPosition(obj, true)
        SetEntityAsMissionEntity(obj)
        SetModelAsNoLongerNeeded(modelHash)
    end
    for k,v in pairs(Config.Mushroom) do
        local modelHash = `S_INV_PARASOL01BX`
        loadModel(modelHash)
        obj = CreateObject(modelHash, v.x, v.y, v.z-1.0, true, true, true)
        PlaceObjectOnGroundProperly(obj)
        FreezeEntityPosition(obj, true)
        SetEntityAsMissionEntity(obj)
        SetModelAsNoLongerNeeded(modelHash)
    end
end)

-- PEYOTE
Citizen.CreateThread(function()
    while true do
        local wait = 500
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        for k,v in pairs(Config.Peyote) do
            if #(v - playerCoords) < 5 then
                wait = 5
                if #(v - playerCoords) < 1 and not isPicking then
                    TaskLookAtEntity(playerPed, obj, 3000, 2048, 3)
                    if active == false then
                        PromptSetEnabled(PickPrompt, true)
                        PromptSetVisible(PickPrompt, true)
                        active = true
                    end
                    if PromptHasHoldModeCompleted(PickPrompt) then
                        isPicking = true
                        TriggerEvent('Perry_Kasvit:startPeyote')
                    end
                else
                    if active == true then
                        PromptSetEnabled(PickPrompt, false)
                        PromptSetVisible(PickPrompt, false)
                        active = false
                    end
                end
            end
        end
        Wait(wait)
    end
end)

--MUSHROOM
Citizen.CreateThread(function()
    while true do
        local wait = 500
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        for k,v in pairs(Config.Mushroom) do
            if #(v - playerCoords) < 5 then
                wait = 5
                if #(v - playerCoords) <1 and not isPicking then
                    TaskLookAtEntity(playerPed, obj, 3000, 2048, 3)
                    if active == false then
                        PromptSetEnabled(PickPrompt, true)
                        PromptSetVisible(PickPrompt, true)
                        active = true
                    end
                    if PromptHasHoldModeCompleted(PickPrompt) then
                        isPicking = true
                        TriggerEvent('Perry_Kasvit:startMushroom')
                    end
                else
                    if active == true then
                    PromptSetEnabled(PickPrompt, false)
                    PromptSetVisible(PickPrompt, false)
                    active = false
                    end
                end
            end
        end
        Wait(wait)
    end
end)