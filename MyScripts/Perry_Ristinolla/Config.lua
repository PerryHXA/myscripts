Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118,
}

Config = {}

Config.Command = "ristinolla" -- invite Command (Play With SomeOne)



Config.AcceptKey = 0xD8F73058 -- Accept Invite Key
Config.ToggleMouse = 0x760A9C6F -- Toggle Mouse 

Config.ClosestPlayer = 4.0 -- Distance For Invite

Config.TimeOut = 6000 -- Time Out For sec Player To Accept

Config.GameEndedTimeOut = 4000 -- Time Out To End Game After Win or Loose or Tie 


Config.Notifys = { -- Notify Lang
    ["noOneAround"] = "Ei ketään lähettyvillä!",
    ["succInvite"] = "Kutsuit: ",
    ["InviteFrom"] = "Sait kutsun: ",
    ["Accept"] = "Paina [U] hyväksyäksesi",
    ["Refuse"] = " ei hyväksynyt kutsuasi",
    ["Win"] = "Voitit pelin X - O !",
    ["Loose"] = "Hävisit pelin..",
    ["Tie"] = "Tasapeli",
}


Config.OnXWin = function(Xplayer,Oplayer) -- Function Called When X Win
    print(GetPlayerName(Xplayer).." Beat "..GetPlayerName(Oplayer).." In X - O Game")
    TriggerClientEvent("Perry_Ristinolla:WinNotify",Xplayer)
    TriggerClientEvent("Perry_Ristinolla:LooseNotify",Oplayer)
end

Config.OnOWin = function(Oplayer,Xplayer) -- Function Called When O Win
    print(GetPlayerName(Oplayer).." Beat "..GetPlayerName(Xplayer).." In X - O Game")
    TriggerClientEvent("Perry_Ristinolla:WinNotify",Oplayer)
    TriggerClientEvent("Perry_Ristinolla:LooseNotify",Xplayer)
end

Config.OnTie = function(Xplayer,Oplayer) -- Function Called When No one Win 
    print(GetPlayerName(Xplayer).." Tie With "..GetPlayerName(Oplayer).." In X - O Game")
    TriggerClientEvent("Perry_Ristinolla:TieNotify",Xplayer)
    TriggerClientEvent("Perry_Ristinolla:TieNotify",Oplayer)
end