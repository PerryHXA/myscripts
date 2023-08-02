local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('Oku_Sellit:haevangitut', function(source, cb)
	local _perm = tonumber(source)
	
	exports.oxmysql:execute('SELECT identifier, charid, kaupunki, selli, time, time_s, etunimi, sukunimi FROM user_selli', {}, function (result)
		local vangitut = {}

		for i=1, #result, 1 do
			table.insert(vangitut, {
				name       = GetPlayerName(source),
				identifier = result[i].identifier,
				charid = result[i].charid,
				kaupunki = result[i].kaupunki,
				selli = result[i].selli,
				time      = result[i].time,
				time_s      = result[i].time_s,
				etunimi      = result[i].etunimi,
				sukunimi      = result[i].sukunimi
			})
		end
		cb(vangitut)
	end)
end)

RegisterServerEvent('Oku_Selli:LaitaSelliin')
AddEventHandler('Oku_Selli:LaitaSelliin', function ( id, args, time)
	local _source = source
	local kaupunki = args['Kaupunki']
    local selli = args['Selli']
	local User = VorpCore.getUser(id)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charid = Character.charIdentifier
    local time_m = tostring(time)
    local time = time * 60
    local timestamp = getTime() + time
	local etunimi = Character.firstname
	local sukunimi = Character.lastname
	exports.oxmysql:execute("INSERT INTO user_selli (identifier, charid, kaupunki, selli, time, time_s, etunimi, sukunimi) VALUES (@identifier, @charid, @kaupunki, @selli, @timestamp, @time, @etunimi, @sukunimi)", {["@identifier"] = identifier, ["@charid"] = charid, ["@kaupunki"] = kaupunki, ["@selli"] = selli, ["@timestamp"] = timestamp, ["@time"] = time, ["@etunimi"] = etunimi, ["@sukunimi"] = sukunimi}, function(result)
        if result ~= nil then
            TriggerClientEvent("Oku_Selli:Jailiin", id, time, selli, kaupunki)
        else
			TriggerClientEvent('vorp:TipBottom',_source, "On tapahtunut virhe", 4000) 
        end
    end)
end)

RegisterServerEvent("Oku_Selli:ulos2")
AddEventHandler("Oku_Selli:ulos2", function(identifier, charid)
    local _source = source
	exports.oxmysql:execute('SELECT * FROM user_selli WHERE identifier = @identifier AND charid = @charid', {["@identifier"] = identifier, ["@charid"] = charid}, function(result)
		if result[1] ~= nil then
			local kaupunki = result[1]["kaupunki"]
			exports.oxmysql:execute("DELETE FROM user_selli WHERE identifier = @identifier AND charid = @charid", {["@identifier"] = identifier, ["@charid"] = charid}, function(result)
				if result ~= nil then
					--TriggerClientEvent("Oku_Selli:JaUlos", target_id, kaupunki) 
				else
					TriggerClientEvent('vorp:TipBottom',_source, "On tapahtunut virhe", 4000) 
				end
			end)
		end
	end)
end)

RegisterServerEvent("Oku_Selli:ulos")
AddEventHandler("Oku_Selli:ulos", function(target_id)
    local _source = source
	local User = VorpCore.getUser(target_id)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charid = Character.charIdentifier
	exports.oxmysql:execute('SELECT * FROM user_selli WHERE identifier = @identifier AND charid = @charid', {["@identifier"] = identifier, ["@charid"] = charid}, function(result)
		if result[1] ~= nil then
			local kaupunki = result[1]["kaupunki"]
			exports.oxmysql:execute("DELETE FROM user_selli WHERE identifier = @identifier AND charid = @charid", {["@identifier"] = identifier, ["@charid"] = charid}, function(result)
				if result ~= nil then
					TriggerClientEvent("Oku_Selli:JaUlos", target_id, kaupunki)
				else
					TriggerClientEvent('vorp:TipBottom',_source, "On tapahtunut virhe", 4000) 
				end
			end)
		end
	end)
end)

RegisterServerEvent("Oku_Selli:Aikaa")
AddEventHandler("Oku_Selli:Aikaa", function(target_id, time, newtime)
    local _source = source
	local User = VorpCore.getUser(target_id)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charid = Character.charIdentifier
	exports.oxmysql:execute('SELECT * FROM user_selli WHERE identifier = @identifier AND charid = @charid', {["@identifier"] = identifier, ["@charid"] = charid}, function(result)
        if result[1] ~= nil then
            local time = result[1]["time_s"]
            local id = result[1]["id"]
			exports.oxmysql:execute("UPDATE user_selli SET time_s = @time_s WHERE id = @id", {["@time_s"] = time + newtime, ["@id"] = id})
			exports.oxmysql:execute("UPDATE user_selli SET time = @time WHERE id = @id", {["@time"] = getTime() + time + newtime, ["@id"] = id})
			TriggerClientEvent('vorp:TipBottom',_source, 'Lisättiin '..newtime..' sekuntia tuomioosi, älä yritä paeta', 4000) 
        end
    end)
end)

RegisterServerEvent("Oku_Selli:Tarkista")
AddEventHandler("Oku_Selli:Tarkista", function()
	local _source = source
	Citizen.Wait(2000)
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter 
	local identifier = Character.identifier
	local charid = Character.charIdentifier
	exports.oxmysql:execute('SELECT * FROM user_selli WHERE identifier = @identifier AND charid = @charid', {["@identifier"] = identifier, ["@charid"] = charid}, function(result)
		if (result[1] ~= nil) then
			local time = result[1]["time_s"]
			local id = result[1]["id"]
			local selli = result[1]["selli"]
			local kaupunki = result[1]["kaupunki"]
			exports.oxmysql:execute("UPDATE user_selli SET time = @time WHERE id = @id", {["@time"] = getTime() + time, ["@id"] = id})
			time = tonumber(time)
			TriggerClientEvent("Oku_Selli:Jailiin", _source, time, selli, kaupunki)
		end
	end)
end)

function getTime ()
    return os.time(os.date("!*t"))
end