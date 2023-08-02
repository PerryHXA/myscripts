VORP = exports.vorp_inventory:vorp_inventoryApi()



Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VORP.RegisterUsableItem("vaskooli", function(data)
		TriggerClientEvent('goldpanner:StartPaning', data.source)
	end)
end)


RegisterNetEvent("search")
AddEventHandler("search", function()
    local item = "smallnugget"
    local r = math.random(1,10)
    local _source = source 
    if r < 3 then
        VORP.addItem(_source, item,math.random(1,3))
        TriggerClientEvent("vorp:TipBottom", _source, Config.oro_encontrado, 6000)
        local levelname = 'washing'
        local addxp = math.random(40,90)
        TriggerEvent('Perry_XP:AnnaServerXP', _source, levelname, addxp)
    else
        TriggerClientEvent("vorp:TipBottom", _source, Config.oro_no_encontrado, 6000)
    end
end)