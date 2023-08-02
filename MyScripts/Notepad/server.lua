VORP = exports.vorp_inventory:vorp_inventoryApi()

noteCoords = {}

-- item for short weapon
Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VORP.RegisterUsableItem("notepad", function(data)
		local _source = source
		TriggerClientEvent("vorp_inventory:CloseInv", data.source)
		TriggerClientEvent('notepad:open', data.source)
		CancelEvent()
		VORP.subItem(data.source,"notepad", 1)
	end)
end)

RegisterServerEvent('notepad:getCoords')
AddEventHandler('notepad:getCoords', function()
    TriggerClientEvent('notepad:getCoords', source, noteCoords)
end)

RegisterServerEvent('notepad:saveCoord')
AddEventHandler('notepad:saveCoord', function(coord)
    noteCoords[#noteCoords + 1] = coord
end)

RegisterServerEvent('notepad:deleteCoord')
AddEventHandler('notepad:deleteCoord', function(coord)
    noteCoords[coord] = nil
end)
