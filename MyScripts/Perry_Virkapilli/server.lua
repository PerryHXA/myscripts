local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("whistle", function(data)
		local _source = data.source
		TriggerClientEvent('Perry_Virkapilli:Aloitapilli', _source)
	end)
end)