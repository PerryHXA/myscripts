local attachedProp = nil
local attachedProp2 = nil

local openedNote = false
local getCoords = nil

local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 0xCEFD9220, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

local prompts = GetRandomIntInRange(0, 0xffffff)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = "Paina"
	AvaaLehtio = PromptRegisterBegin()
	PromptSetControlAction(AvaaLehtio,  0x8AAA0AD4) 
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(AvaaLehtio, str)
	PromptSetEnabled(AvaaLehtio, 1)
	PromptSetVisible(AvaaLehtio, 1)
	PromptSetStandardMode(AvaaLehtio,1)
    PromptSetHoldMode(AvaaLehtio, 1)
	PromptSetGroup(AvaaLehtio, prompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,AvaaLehtio,true)
	PromptRegisterEnd(AvaaLehtio)
end)

Citizen.CreateThread(function()
    while true do
        local sleepThread = 500
        --SetNuiFocus(false, false)
        TriggerServerEvent('notepad:getCoords')
        local playerPed = PlayerPedId()
        local pos = GetEntityCoords(playerPed)

        if getCoords ~= nil then
            for k, v in pairs(getCoords) do
                local noteDist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true)

                SetPlayerTalkingOverride(playerPed, true)

                if noteDist < 5 then
                    sleepThread = 5
					local label  = CreateVarString(10, 'LITERAL_STRING', "LEHTIÖ") -- TRANSLATE HERE
					PromptSetActiveGroupThisFrame(prompts, label)

					if Citizen.InvokeNative(0xC92AC953F0A982AE,AvaaLehtio) then
                        TriggerServerEvent('notepad:deleteCoord', k)
                        TriggerEvent('notepad:pickup', v.noteTxt, k)
                    end
                end
            end
        end
        Citizen.Wait(sleepThread)
    end
end)

RegisterNetEvent('notepad:open')
AddEventHandler('notepad:open', function()
    SetNuiFocus(true, false)
    SendNUIMessage({ type = 'showpage' })

    openedNote = true

    TriggerEvent('notepad:anim')
end)

RegisterNetEvent('notepad:pickup')
AddEventHandler('notepad:pickup', function(txt, id)
	deletemuistio()
    SetNuiFocus(true, false)

    openedNote = true

    SendNUIMessage({
        type = 'pickup',
        notetxt = txt,
        noteid = id
    })

    TriggerEvent('notepad:pickupanim')
end)

RegisterNetEvent('notepad:pickupanim')
AddEventHandler('notepad:pickupanim', function()
    RequestAnimDict("pickup_object")
    while not HasAnimDictLoaded("pickup_object") do
        Citizen.Wait(0)
    end

    TaskPlayAnim(GetPlayerPed(-1), "pickup_object", "pickup_low", 8.0, -8, -1, 9, 0, 0, 0, 0)
    Wait(2000)
    ClearPedTasks(GetPlayerPed(-1))
end)

local function loadModel(model)
    if not HasModelLoaded(model) then
        RequestModel(model)
    end
    while not HasModelLoaded(model) do
        Wait(10)
    end
end

function deletemuistio()
	local entity = modeltodelete
    NetworkRequestControlOfEntity(entity)
    local timeout = 2000
    while timeout > 0 and not NetworkHasControlOfEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end
    SetEntityAsMissionEntity(entity, true, true)
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
    
    if (DoesEntityExist(entity)) then 
		DeleteEntity(entity)
		modeltodelete = nil
	end
	modeltodelete = nil
end

RegisterNetEvent('notepad:dropnote')
AddEventHandler('notepad:dropnote', function(txt)
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)

    newNote = {
        x = pos.x,
        y = pos.y,
        z = pos.z,
        noteTxt = txt
    }

    TriggerServerEvent("notepad:saveCoord", newNote)
	local modelHash = `p_cs_note01x`
	loadModel(modelHash)
	obj = CreateObject(modelHash, pos.x, pos.y, pos.z-1.0, true, true, true)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
    SetEntityAsMissionEntity(obj)
    SetModelAsNoLongerNeeded(modelHash)
	modeltodelete = obj
end)

RegisterNetEvent('notepad:getCoords')
AddEventHandler('notepad:getCoords', function(coords)
    if coords ~= nil then
        getCoords = coords
    end
end)

RegisterNUICallback('getNote', function(data)
    TriggerEvent('notepad:dropnote', data)
    openedNote = false
end)

RegisterNUICallback('destroynote', function(data)
    TriggerServerEvent('notepad:deleteCoord', data)
    openedNote = false
end)

RegisterNUICallback('NUIFocusOff', function()
    SetNuiFocus(false, false)
    openedNote = false

    ClearPedTasksImmediately(GetPlayerPed(-1))
    DeleteObject(attachedProp)
    DeleteObject(attachedProp2)
end)

function Draw3DText(x, y, z, text,messageTimeout)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())  
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 2)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    if onScreen then
        SetTextScale(0.30, 0.30)
        SetTextFontForCurrentCommand(1)
        SetTextColor(255, 255, 255, 215)
        SetTextCentre(1)
        DisplayText(str,_x,_y-0.262)
        --DisplayText(str,_x,_y)
        local factor = (string.len(text)) / 225
        DrawSprite("feeds", "hud_menu_4a", _x, _y-0.250,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
        --DrawSprite("feeds", "toast_bg", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
    end
end