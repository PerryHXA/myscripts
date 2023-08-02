local config = Config
local hunger = 100
local thirst = 100
local health = 100
local temp = 0
local dev = false
local isLoggedIn = false

AddEventHandler('onClientResourceStart', function (resourceName)
  if(GetCurrentResourceName() ~= resourceName) then
    return
  end
  isLoggedIn = true
end)



--[[
RegisterCommand("hud", function(source, args, rawCommand)
	if isLoggedIn == true then
        isLoggedIn = false
	else
        isLoggedIn = true
	end
end)]]

-- Reset hud
local function restartHud()
    SendNUIMessage({ action = 'hudtick', show = false })
    SendNUIMessage({ action = 'hudtick', show = true })
end

RegisterNUICallback('restartHud', function(_, cb)
    Wait(50)
    restartHud()
    cb("ok")
end)

RegisterCommand('resethud', function(_, cb)
    Wait(50)
    restartHud()
    cb("ok")
end)

RegisterNUICallback('dynamicHorses', function(_, cb)
    Wait(50)
    Menu.isDynamicHorsesChecked = not Menu.isDynamicHorsesChecked
    saveSettings()
    cb("ok")
end)

-- Status
RegisterNUICallback('dynamicHealth', function(_, cb)
    Wait(50)
    TriggerEvent("hud:client:ToggleHealth")
    cb("ok")
end)

RegisterNetEvent("hud:client:ToggleHealth", function()
    Wait(50)
    Menu.isDynamicHealthChecked = not Menu.isDynamicHealthChecked
    saveSettings()
end)

RegisterNUICallback('dynamicHorseh', function(_, cb)
    Wait(50)
    Menu.isDynamicHorsehChecked = not Menu.isDynamicHorsehChecked
    saveSettings()
    cb("ok")
end)

RegisterNUICallback('dynamicHunger', function(_, cb)
    Wait(50)
    Menu.isDynamicHungerChecked = not Menu.isDynamicHungerChecked
    saveSettings()
    cb("ok")
end)

RegisterNUICallback('dynamicThirst', function(_, cb)
    Wait(50)
    Menu.isDynamicThirstChecked = not Menu.isDynamicThirstChecked
    saveSettings()
    cb("ok")
end)

RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst) 
    hunger = newHunger
    thirst = newThirst
end)


local prevPlayerStats = { nil, nil, nil, nil, nil, nil, nil, nil, nil}

function updatePlayerHud(data)
    local shouldUpdate = false
    for k, v in pairs(data) do
        if prevPlayerStats[k] ~= v then
            shouldUpdate = true
            break
        end
    end
    prevPlayerStats = data
    if shouldUpdate then
        SendNUIMessage({
            action = 'hudtick',
            show = data[1], 
            thirst = data[2],
            hunger = data[3],
            health = data[4],
			temp = data[5],
        })
    end
end

-- HUD Update loop

CreateThread(function()
    while true do
        Wait(50)
        if isLoggedIn then
            local show = true
            local player = PlayerPedId()
			local coords = GetEntityCoords(player)
			local paska = GetTemperatureAtCoords(coords)
			local tempo = math.floor(paska).."°C"
            if isLoggedIn then
				updatePlayerHud({
					show,  
					thirst,
					hunger,  
					GetEntityHealth(player),  
					tempo,
				})
            end
        else
            SendNUIMessage({
                action = 'hudtick',
                show = false
            })
        end
    end
end)

local function saveSettings()
    SetResourceKvp('hudSettings', json.encode(Menu))
end


RegisterNetEvent('hudoff', function()
    isLoggedIn = false
    Citizen.InvokeNative(0x4CC5F2FC1332577F, 474191950)
    TriggerEvent('syn_displayrange2', true)
end)

local togglehud = false
RegisterCommand('hudi', function()
    if not togglehud then
        isLoggedIn = false
        togglehud = true
        Citizen.InvokeNative(0x4CC5F2FC1332577F, 474191950)
        TriggerEvent('syn_displayrange2', true)
    else
        Citizen.InvokeNative(0x8BC7C1F929D07BF3, 474191950)
        isLoggedIn = true
        togglehud = false
        restartHud()
        TriggerEvent('syn_displayrange2', false)
    end
end)

local togglekartta = false
RegisterCommand('karttapois', function()
    if not togglekartta then
        togglekartta = true
        Citizen.InvokeNative(0x4CC5F2FC1332577F, 474191950)
    else
        Citizen.InvokeNative(0x8BC7C1F929D07BF3, 474191950)
        togglekartta = false
    end
end)


RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
    Citizen.CreateThread(function()
        isLoggedIn = true
        restartHud()
    end)
end)