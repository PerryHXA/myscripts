local webhook = ""

AddEventHandler("playerDropped", function(reason)
    local crds = GetEntityCoords(GetPlayerPed(source))
    local id = source
    local identifier = ""
    identifier = GetPlayerIdentifiers(source)[1]
	sendToDiscord("Kellotuslogit", "ID: "..id.." ("..identifier..")\nSyy: "..reason, 16711680)
    TriggerClientEvent("perry_noclog", -1, id, crds, identifier, reason)
end)

local DISCORD_WEBHOOK = "webhookmissing"
local DISCORD_NAME = "Kellotuslogit"
local STEAM_KEY = ""
local DISCORD_IMAGE = "https://i.imgur.com/CLoTdx1.jpg" -- default is FiveM logo

function sendToDiscord(name, message, color)
  local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "",
            },
        }
    }
  PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end