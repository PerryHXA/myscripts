ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

ESX.RegisterServerCallback('Perry_Kamppa:HaeLockpick', function(source, cb)
	local _source = source
	local count = VorpInv.getItemCount(_source, "lockpick")
	cb(count)
end)

RegisterServerEvent("Perry_Kampat:Remove")
AddEventHandler("Perry_Kampat:Remove", function(item, count)
	local _source = source
	VorpInv.subItem(_source, item, count)
	TriggerClientEvent("vorp:TipRight", _source, '-1 '..item, 5000)
end)

RegisterServerEvent('Perry_Kampat:rob')
AddEventHandler('Perry_Kampat:rob', function(asunto)
    local src = source
    Config.Asunnot[asunto].robbed = true
    local second = 1000
    local minute = 60 * second
    local hour = 60 * minute
    local cooldown = Config.Asunnot[asunto].cooldown
	print(cooldown.hour)
    local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
    Citizen.Wait(wait)
	print("Wait ohi")
    Config.Asunnot[asunto].robbed = false
end)

ESX.RegisterServerCallback('Perry_Kamppa:canRob', function(source, cb, asunto)
    if not Config.Asunnot[asunto].robbed then
        cb(true)
    else
        cb(false)
    end
end)