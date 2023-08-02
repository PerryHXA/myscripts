local VorpInv = {}

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent('Wiplerilypsa:Palkinto')
AddEventHandler('Wiplerilypsa:Palkinto', function(item, count)
	local _source = source
	VorpInv.addItem(_source, item, count)
	TriggerClientEvent("vorp:TipRight", _source, "Sait ".. count.. "x ".. item, 5000)
end)

RegisterServerEvent('Perry_Keritsimet:Keritsimet')
AddEventHandler('Perry_Keritsimet:Keritsimet', function(targetEntity)
	local _source = source
	local itemCount = VorpInv.getItemCount(_source, "keritsin")
	if itemCount >= 1 then
		TriggerClientEvent("Perry_Keritsimet:Keraa", _source, targetEntity)
	else
		TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole keritsimiä!", 5000)
	end
end)