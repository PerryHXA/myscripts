ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent('Perry_Mehilainen:startdumpsterTimer')
AddEventHandler('Perry_Mehilainen:startdumpsterTimer', function(car)
    startTimer(source, car)
end)

RegisterServerEvent('Perry_Mehilainen:rewarditem')
AddEventHandler('Perry_Mehilainen:rewarditem', function(listKey)
    local src = source 
    local User = VorpCore.getUser(src)
    local Character = User.getUsedCharacter
	VorpInv.addItem(src, "honey", 1)
	TriggerClientEvent("vorp:TipRight", src, "Keräsit hunajaa!", 4000) -- from server side
end)

function startTimer(id, object)
    local timer = 10 * 60000

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            TriggerClientEvent('Perry_Mehilainen:removedumpster', id, object)
        end
    end
end

ESX.RegisterServerCallback('Perry_Mehilainen:EtsiPurkki', function(source, cb)
	local _source = source
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
	local maara = VorpInv.getItemCount(_source, "lasipurkki")
	if maara >= 1 then
		cb(true)
	else
		cb(false)
	end
end)