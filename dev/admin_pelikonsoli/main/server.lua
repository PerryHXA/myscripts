TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local VorpCore = {}

VORP = exports.vorp_inventory:vorp_inventoryApi()


Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VORP.RegisterUsableItem("nintendo", function(data)
		local _source = data.source
		TriggerClientEvent('stg_switch:use', _source)
	end)
end)