local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent('Perry_Madam:OstaTuote')
AddEventHandler('Perry_Madam:OstaTuote', function(argut)
	local itemi = argut.itemi
	local hinta = argut.hinta
	local label = argut.label
	local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter 
	local money = Character.money
	local canCarry = VorpInv.canCarryItem(_source, itemi, 1)
	if canCarry then
		if money >= hinta then
			Character.removeCurrency(0, hinta)
			VorpInv.addItem(_source, itemi, 1)
			TriggerClientEvent('vorp:TipBottom', _source, "Ostit tuotteen "..label, 4000)
		else
			TriggerClientEvent('vorp:TipBottom', _source, "Sinulla ei ole tarpeeksi rahaa!", 4000)
		end
	else
		TriggerClientEvent('vorp:TipBottom', _source, "Sinulla ei ole repussa tilaa!", 4000)
	end
end)