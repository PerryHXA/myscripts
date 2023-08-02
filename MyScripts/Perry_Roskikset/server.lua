local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

local VORPInv = {}

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Perry_Roskikset:startdumpsterTimer')
AddEventHandler('Perry_Roskikset:startdumpsterTimer', function(car)
    startTimer(source, car)
end)

RegisterServerEvent('Perry_Roskis:Laita')
AddEventHandler('Perry_Roskis:Laita', function(entity)
	print("jeee")
	local paska = tostring(entity)
	VorpInv.registerInventory(paska, "Roskakori", 100, true, true)
	VorpInv.OpenInv(source,paska) 
end)

RegisterServerEvent('Perry_Roskikset:rewarditem')
AddEventHandler('Perry_Roskikset:rewarditem', function(listKey)

    local src = source 
    local User = VORPcore.getUser(src)
    local Character = User.getUsedCharacter
	local item = Config.Items[math.random(1, #Config.Items)]
	local itemi = VorpInv.getDBItem(src, item)
    local itemlabel = itemi.label
	VorpInv.addItem(src, item, 1)
	TriggerClientEvent('vorp:TipBottom',src, "Löysit "..itemlabel, 4000) 
	local Luck = math.random(1, 8)
	local Odd = math.random(1, 8)
	if Luck == Odd then
		local ammo = {["nothing"] = 0}
		local components =  {["nothing"] = 0}
		VorpInv.createWeapon(tonumber(src), "WEAPON_MELEE_KNIFE_JAWBONE ", ammo, components)
	end
end)

function startTimer(id, object)
    local timer = 10 * 60000

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            TriggerClientEvent('Perry_Roskikset:removedumpster', id, object)
        end
    end
end