local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

VorpInv.RegisterUsableItem("kaarmeseerumi", function(data)
	VorpInv.CloseInv(data.source)
    VorpInv.subItem(data.source, "kaarmeseerumi", 1)
	TriggerClientEvent("Perry_Poison:UseAntidote", data.source)
end)


RegisterServerEvent('Perry_Poison:Serveritoclient')
AddEventHandler('Perry_Poison:Serveritoclient', function(target)
	TriggerClientEvent('Perry_Poison:Effektit', target)
end)