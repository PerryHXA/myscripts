local VorpCore = {}

VORP = exports.vorp_inventory:vorp_inventoryApi()

local harvestXPmultiplier = 1

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VORP.RegisterUsableItem("reppu1", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Reput:reppu1", _source)
		VORP.CloseInv(data.source)
	end)
	VORP.RegisterUsableItem("reppu2", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Reput:reppu2", _source)
		VORP.CloseInv(data.source)
	end)
	VORP.RegisterUsableItem("reppu3", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Reput:reppu3", _source)
		VORP.CloseInv(data.source)
	end)
	VORP.RegisterUsableItem("plagmaski1", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Reput:plaguemaskit", _source, "mlohub_plague_mask01")--mlohub_plague_mask01
		VORP.CloseInv(data.source)
	end)
	VORP.RegisterUsableItem("plagmaski2", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Reput:plaguemaskit", _source, "mlohub_plague_mask02")
		VORP.CloseInv(data.source)
	end)
	VORP.RegisterUsableItem("plagmaski3", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Reput:plaguemaskit", _source, "mlohub_plague_mask03")
		VORP.CloseInv(data.source)
	end)
	VORP.RegisterUsableItem("plagmaski4", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Reput:plaguemaskit", _source, "mlohub_plague_mask04")
		VORP.CloseInv(data.source)
	end)
	--[[
	VORP.RegisterUsableItem("kaasumaski", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Reput:kaasumaski", _source, "gasmask01")
		VORP.CloseInv(data.source)
	end)
	--]]
	VORP.RegisterUsableItem("kaasumaski", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Reput:native", _source, "mlohub_native_headdress01")
		VORP.CloseInv(data.source)
	end)
end)

VORP.RegisterUsableItem("p_badge", function(data)
	TriggerClientEvent('jimbo_badge:putOn', data.source)
	VORP.CloseInv(data.source)
end)

VORP.RegisterUsableItem("m_badge", function(data)
	TriggerClientEvent('jimbo_badge:putOn', data.source)
	VORP.CloseInv(data.source)
end)

VORP.RegisterUsableItem("l_badge", function(data)
	TriggerClientEvent('jimbo_badge:putOn', data.source)
	VORP.CloseInv(data.source)
end)