local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VORP = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent('Oku_Kuljetusduuni:TarkistaAvain')
AddEventHandler('Oku_Kuljetusduuni:TarkistaAvain', function()
	local _source = source
	local itemCount = VORP.getItemCount(_source, "crackpot_avain")
	if itemCount >= 1 then
		TriggerClientEvent('vorp:TipBottom', _source, "Montako avainta oikein tarvitset?", 4000)
	else
		TriggerClientEvent("Oku_Kuljetusduuni:Aloita", _source)
	end
end)

RegisterServerEvent('Oku_Kuljetusduuni:AnnaAvain')
AddEventHandler('Oku_Kuljetusduuni:AnnaAvain', function()
	local _source = source
	local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local canCarry = VORP.canCarryItem(_source, "crackpot_avain", 1)
	if canCarry then
		VORP.addItem(_source, "crackpot_avain", 1) -- source, itemname, quantity
		TriggerClientEvent('vorp:TipBottom', _source, "Paikka on merkitty karttaasi ja avain taskussasi!", 4000)
		TriggerClientEvent("Oku_Kuljetusduuni:GPS", _source)
	else
		TriggerClientEvent('vorp:TipBottom', _source, "Sinulla ei ole repussa tilaa!", 4000)
	end
end)


RegisterNetEvent("Oku_Kuljetusduuni:SuljeOvet")
AddEventHandler("Oku_Kuljetusduuni:SuljeOvet", function()
	TriggerClientEvent("Oku_Kuljetusduuni:SuljeOvi", -1)
end)

RegisterNetEvent("Oku_Kuljetusduuni:AvaaOvet")
AddEventHandler("Oku_Kuljetusduuni:AvaaOvet", function()
	TriggerClientEvent("Oku_Kuljetusduuni:AvaaOvi", -1)
end)