local VorpCore = {}

VORP = exports.vorp_inventory:vorp_inventoryApi()

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VORP.RegisterUsableItem("muunnos_seerumi", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Kasvit:eatPeyote", _source) 
	end)
	VORP.RegisterUsableItem("mushroom", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Kasvit:eatMushroom", _source)
	end)
	VORP.RegisterUsableItem("Alaskan_Ginseng", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Kasvit:eatGinseng", _source) 
	end)
end)

RegisterNetEvent("Perry_Kasvit:pickMushroom")
AddEventHandler("Perry_Kasvit:pickMushroom", function()
    local item = "mushroom"
    local _source = source 
	VORP.addItem(_source, item, math.random(1,3))
	TriggerClientEvent('vorp:TipBottom', _source, "Sait 1x Meskaliinikaktus!", 4000) -- TOIMII
end)

RegisterNetEvent("Perry_Kasvit:pickPeyote")
AddEventHandler("Perry_Kasvit:pickPeyote", function()
    local item = "meskaliinikaktus"
    local _source = source 
	VORP.addItem(_source, item, math.random(1,3))
	TriggerClientEvent('vorp:TipBottom', _source, "Sait 1x Meskaliinikaktus!", 4000) -- TOIMII
end)

RegisterNetEvent("Perry_Kasvit:pickGinseng")
AddEventHandler("Perry_Kasvit:pickGinseng", function()
    local item = "ginseng"
    local _source = source 
	VORP.addItem(_source, item, math.random(1,3))
	TriggerClientEvent('vorp:TipBottom', _source, "Sait 1x Meskaliinikaktus!", 4000) -- TOIMII
end)