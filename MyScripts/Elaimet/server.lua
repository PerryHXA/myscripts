RegisterNetEvent("fixanimals:attack")

AddEventHandler("fixanimals:attack", function(target, entity)
	TriggerClientEvent("fixanimals:attack", target, source, entity)
end)


RegisterCommand('vaihda', function(source, args, rawCommand)
    local _source = source
    local ace = IsPlayerAceAllowed(_source, "vorp.staff.AdminActions")
	if ace then
		local model = args[1]
		TriggerEvent('discordbot:pedivaihto', GetPlayerName(source) .. " vaihtoi " .. model .. " modeliin")
		TriggerClientEvent('Perry_Pedit:VaihdaPedi', _source, model)
	else
		TriggerClientEvent("vorp:Tip", _source, "Not enough permission", 5000)
	end
end)

RegisterServerEvent('discordbot:pedivaihto')
AddEventHandler('discordbot:pedivaihto',function(message)
    sendToDiscord("PediLogit", message, 16711680)
end)

local DISCORD_WEBHOOK = "webhookmissing"
local DISCORD_NAME = "Abuselogit"
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