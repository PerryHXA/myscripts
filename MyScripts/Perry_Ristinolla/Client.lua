-- // LOCALS \\ --
local toggle = false
local GameActive = false


-- // FUNCTIONS \\ --

function StartGame(OtherPlayer,GameID,meinv) 
    SendNUIMessage({
        Start = true,
        OtherPlayer = OtherPlayer,
        GameID = GameID,
        meinv = meinv
    })
    GameActive = true
    toggle = true
    SetNuiFocus(toggle,toggle)
    SetNuiFocusKeepInput(toggle)
end

function CheckPlace(player,place)
    SendNUIMessage({
        CheckPlace = true,
        Pplayer = player,
        Pplace = place
    })
end

function StopGame()
    SendNUIMessage({
        Stop = true,
    })
    GameActive = false
    toggle = false
    SetNuiFocus(toggle,toggle)
    SetNuiFocusKeepInput(toggle)
end


-- // Commands \\ --

RegisterCommand(Config.Command, function(source, args, RawCommand)
    local player,closestDistance = GetClosestPlayer()
    if player ~= -1 and closestDistance <= Config.ClosestPlayer then
        TriggerServerEvent("Perry_Ristinolla:SendInvite", GetPlayerServerId(player))
		exports['mythic_notify']:DoLongHudText('Error', Config.Notifys["succInvite"]..GetPlayerName(player))
    else
        exports['mythic_notify']:DoLongHudText('Error', 'Ei ketään lähettyvillä!')
    end
end)

RegisterCommand('togglemouse', function(source, args, RawCommand)
    if GameActive then
        toggle = not toggle
        SetNuiFocus(toggle,toggle)
        SetNuiFocusKeepInput(toggle)
    end
end)
RegisterKeyMapping("togglemouse", "To Toggle Mouse In TicTacToe Game (X - O)", "keyboard", Config.ToggleMouse)


-- // NUICALLBACk \\ --

RegisterNUICallback("checked", function(data)
    TriggerServerEvent("Perry_Ristinolla:PlaceChecked", data.GameID,data.player,data.place)
end)
RegisterNUICallback("win", function(data)
    TriggerServerEvent("Perry_Ristinolla:Win", data.GameID,data.status)
end)

RegisterNUICallback("exit", function(data)
    StopGame()
    GameActive = false -- just to make shure :)
    TriggerServerEvent("Perry_Ristinolla:EndGame", data.GameID)
end)



-- // Events \\ --


RegisterNetEvent("Perry_Ristinolla:StartGame")
AddEventHandler("Perry_Ristinolla:StartGame", StartGame)

RegisterNetEvent("Perry_Ristinolla:StopGame")
AddEventHandler("Perry_Ristinolla:StopGame", StopGame)

RegisterNetEvent("Perry_Ristinolla:SendInvite")
AddEventHandler("Perry_Ristinolla:SendInvite", function(inviter)
    local inviter = inviter
	exports['mythic_notify']:DoLongHudText('Error', Config.Notifys["InviteFrom"]..GetPlayerName(GetPlayerFromServerId(inviter)))
    local state;
    local TimeOut = Config.TimeOut
    SetTimeout(Config.TimeOut, function()
        if not state then
            state = false
            TriggerServerEvent("Perry_Ristinolla:Refused",inviter)
        end
    end)
    while state == nil do
        Wait(1)
        if IsControlJustPressed(0, 0xD8F73058) then
            state = true
            TriggerServerEvent("Perry_Ristinolla:StartGame", inviter)
        end
    end
end)

RegisterNetEvent("Perry_Ristinolla:Refused")
AddEventHandler("Perry_Ristinolla:Refused", function(Refuser)
    local Refuser = GetPlayerFromServerId(Refuser)
    exports['mythic_notify']:DoLongHudText('Error', GetPlayerName(Refuser)..Config.Notifys["Refuse"])
end)

RegisterNetEvent("Perry_Ristinolla:CheckPlace")
AddEventHandler("Perry_Ristinolla:CheckPlace", CheckPlace)

RegisterNetEvent("Perry_Ristinolla:WinNotify")
AddEventHandler("Perry_Ristinolla:WinNotify", function()
	exports['mythic_notify']:DoLongHudText('Error', Config.Notifys["Win"])
end)

RegisterNetEvent("Perry_Ristinolla:LooseNotify")
AddEventHandler("Perry_Ristinolla:LooseNotify", function()
	exports['mythic_notify']:DoLongHudText('Error', Config.Notifys["Loose"])
end)

RegisterNetEvent("Perry_Ristinolla:TieNotify")
AddEventHandler("Perry_Ristinolla:TieNotify", function()
	exports['mythic_notify']:DoLongHudText('Error', Config.Notifys["Tie"])
end)


-- // Some Useful Things \\ --

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end


function GetPlayers()
    local players = {}
    
    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
    
    return players
end

function Notify(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0,1)
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if toggle then
            DisableControlAction(0, 142, true)
        end
    end
end)