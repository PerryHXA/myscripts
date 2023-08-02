ESX = nil

local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('Perry_Varikko:Tarkistakaikki', function(source, cb)
    local _source = source
	local User = VORPcore.getUser(_source)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charid = Character.charIdentifier
	local tallissa = 0
	MySQL.Async.fetchAll('SELECT * FROM ricxhorses WHERE identifier = @identifier AND charid = @charid AND tallissa = @tallissa', {["@identifier"] = identifier, ["@charid"] = charid, ["@tallissa"] = tallissa}, function(result)
		local hepat = {}

		for i=1, #result, 1 do
			table.insert(hepat, {
				model       = result[i].model,
				name       = result[i].name,
				talli       = result[i].talli
			})
		end
		cb(hepat)
	end)
end)


RegisterServerEvent("Perry_Varikko:OtetaanTalliin")
AddEventHandler("Perry_Varikko:OtetaanTalliin", function(model, name, hinta)
	local _source = source
	local User = VORPcore.getUser(_source)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charid = Character.charIdentifier
	local heppa = model
	local nimi = name
	local rahat = Character.money
	if rahat >= hinta then
		Character.removeCurrency(0, hinta)
		MySQL.Async.execute("UPDATE ricxhorses SET tallissa = @tallissa WHERE identifier = @identifier AND charid = @charid AND model = @model AND name = @name", {["@tallissa"] = 1, ["@identifier"] = identifier, ["@charid"] = charid, ["@model"] = heppa, ["@name"] = nimi})
		TriggerClientEvent('vorp:TipBottom',_source, 'Heppa palautettu talliin, maksoit 5$', 4000) 
	else
		TriggerClientEvent('vorp:TipBottom',_source, 'Sinulla ei ole tarpeeksi rahaa', 4000) 
	end
end)