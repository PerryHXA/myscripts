
local Games = {}


RegisterServerEvent("Perry_Ristinolla:StartGame")
AddEventHandler("Perry_Ristinolla:StartGame", function(inviter)
   local src = source
   local inviter = inviter
   local GameID = makeid(12)
   Games[GameID] = {
       x = inviter,
       o = src,

   }
   TriggerClientEvent("Perry_Ristinolla:StartGame",inviter,GetPlayerName(src),GameID,true)
   TriggerClientEvent("Perry_Ristinolla:StartGame",src,GetPlayerName(inviter),GameID,false)
end)

RegisterServerEvent("Perry_Ristinolla:EndGame")
AddEventHandler("Perry_Ristinolla:EndGame", function(GameID)
   if Games[GameID] then
    TriggerClientEvent("Perry_Ristinolla:StopGame", Games[GameID].x)
    TriggerClientEvent("Perry_Ristinolla:StopGame", Games[GameID].o)
    Games[GameID] = nil
   end
end)

RegisterServerEvent("Perry_Ristinolla:PlaceChecked")
AddEventHandler("Perry_Ristinolla:PlaceChecked", function(GameID,player,place)
    local player,place = player,place
    if Games[GameID] then
        TriggerClientEvent("Perry_Ristinolla:CheckPlace", Games[GameID].x,player,place)
        TriggerClientEvent("Perry_Ristinolla:CheckPlace", Games[GameID].o,player,place)
    end
end)

RegisterServerEvent("Perry_Ristinolla:Win")
AddEventHandler("Perry_Ristinolla:Win", function(GameID,status)
    local GameID = GameID
    local Winner = status
    if Games[GameID] then
        if Winner == 'x' then
            Config.OnXWin(Games[GameID].x,Games[GameID].o)
        elseif Winner == "o" then
            Config.OnOWin(Games[GameID].o,Games[GameID].x)
        elseif Winner == "Tie" then
            Config.OnTie(Games[GameID].x,Games[GameID].o)
        end
        SetTimeout(Config.GameEndedTimeOut, function()
            TriggerEvent("Perry_Ristinolla:EndGame", GameID)
        end)
    end
end)

RegisterServerEvent("Perry_Ristinolla:SendInvite")
AddEventHandler("Perry_Ristinolla:SendInvite", function(player)
   TriggerClientEvent("Perry_Ristinolla:SendInvite", player, source)
end)

RegisterServerEvent("Perry_Ristinolla:Refused")
AddEventHandler("Perry_Ristinolla:Refused", function(inviter)
    TriggerClientEvent("Perry_Ristinolla:Refused", inviter, source)
   
end)


function makeid(length)
    local upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local lowerCase = "abcdefghijklmnopqrstuvwxyz"
    local numbers = "0123456789"
    
    local characterSet = upperCase .. lowerCase .. numbers
    
    local keyLength = length
    local output = ""
    
    for	i = 1, keyLength do
        local rand = math.random(#characterSet)
        output = output .. string.sub(characterSet, rand, rand)
    end
    return output
end