local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent('Perry_Juna:MaksaJunasta')
AddEventHandler('Perry_Juna:MaksaJunasta', function(price, hash)
	local _source = source
	local identifier = GetPlayerIdentifiers(source)[1]
	local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter 
	if Character.money > price then
		Character.removeCurrency(0, price)
		TriggerClientEvent("vorp:TipBottom", _source, 'Maksoit vuokrasta '..price.."$", 4000)
		TriggerClientEvent("Perry_Juna:Spawnaajuna", _source, hash)
	else
		TriggerClientEvent("vorp:TipBottom", _source, 'Sinulla ei ole tarpeeksi rahaa', 4000)
	end
end)

RegisterServerEvent('Perry_Juna:MaksaRatikasta')
AddEventHandler('Perry_Juna:MaksaRatikasta', function(price, hash)
	local _source = source
	local identifier = GetPlayerIdentifiers(source)[1]
	local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter 
	if Character.money > price then
		Character.removeCurrency(0, price)
		TriggerClientEvent("vorp:TipBottom", _source, 'Maksoit vuokrasta '..price.."$", 4000)
		TriggerClientEvent("Perry_Juna:Spawnaaratikka", _source, hash)
	else
		TriggerClientEvent("vorp:TipBottom", _source, 'Sinulla ei ole tarpeeksi rahaa', 4000)
	end
end)