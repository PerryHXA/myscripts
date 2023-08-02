local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("jaatelokm", function(data)
		local object = "p_icecream01"
		TriggerClientEvent('icecream:eaticecream', data.source, object, 500)
	end)
end)